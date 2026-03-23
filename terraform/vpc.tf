resource "aws_vpc" "demo_vpc" {
    cidr_block = "10.0.0.0/25"
    enable_dns_hostnames = true

    tags = {
      Name = "main-vpc"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "10.0.1.0/27"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet"
    }  
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "10.0.2.0/27"
    availability_zone = "ap-south-1b"

    tags = {
      Name = "private-subnet"
    }
}

resource "aws_internet_gateway" "demo-igw" {
    vpc_id = aws_vpc.demo_vpc.id

    tags = {
      Name = "demo-vpc-igw"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.demo_vpc.id

    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo-igw.id
    }

    tags = {
      Name = "public-rt"
    }
}

resource "aws_route_table_association" "public_rt_assc" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "main-nat"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "demo_vpc_sg" {
    name = "demo-vpc-sg"
    description = "Adding SSH and TCP rules"
    vpc_id = aws_vpc.demo_vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "ssh"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress = {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "ec2-sg"
        }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0f5ee92e2d63afc18" # Amazon Linux (Mumbai)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id

  vpc_security_group_ids = [aws_security_group.demo_vpc_sg.id]

  tags = {
    Name = "private-ec2"
  }
}