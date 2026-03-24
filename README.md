# 🚀 AWS Production-Ready Scalable Web Application

## 📌 Project Overview

This project demonstrates a production-ready cloud architecture built on AWS using DevOps best practices. It showcases infrastructure automation, scalability, high availability, and CI/CD implementation.

---

## 🏗️ Architecture

![Architecture Diagram](architecture/architecture.png)

---

## ⚙️ Tech Stack

* **Cloud Provider:** AWS
* **Infrastructure as Code:** Terraform
* **Compute:** EC2 (Auto Scaling Group)
* **Load Balancer:** Application Load Balancer (ALB)
* **Networking:** VPC, Subnets, NAT Gateway, Internet Gateway
* **Containerization:** Docker
* **CI/CD:** Jenkins
* **Version Control:** GitHub

---

## 🔥 Key Features

* Highly available architecture using Auto Scaling
* Load balancing with AWS ALB
* Secure infrastructure with public & private subnets
* NAT Gateway for private subnet internet access
* Infrastructure provisioning using Terraform
* Dockerized application deployment
* CI/CD pipeline using Jenkins

---

## 🚀 How It Works

1. User sends request to Application Load Balancer
2. ALB distributes traffic to EC2 instances
3. EC2 instances run Docker containers with the app
4. Auto Scaling ensures availability and scaling
5. Jenkins automates deployment from GitHub

---

## 📂 Project Structure

```
aws-production-webapp/
│
├── terraform/        # Infrastructure code
├── app/              # Flask application
├── docker/           # Docker configuration
├── jenkins/          # CI/CD pipeline
├── architecture/     # Architecture diagram
└── README.md
```

---

## 🧠 Learnings

* Designed scalable AWS architecture
* Implemented Infrastructure as Code using Terraform
* Built CI/CD pipeline with Jenkins
* Deployed containerized applications using Docker

---

## 📌 Future Improvements

* Add HTTPS using ACM
* Use multiple AZs for high availability
* Integrate monitoring (CloudWatch + alerts)
* Deploy using Kubernetes (EKS)

---

## 🙌 Author

**Nikita Kotambe**
