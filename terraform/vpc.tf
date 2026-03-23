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