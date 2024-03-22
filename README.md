# DevOps CI/CD Pipeline with Terraform, SonarQube, and AWS
[Live website](https://www.moesportfolio.com/)
## Overview
This repository contains the infrastructure as code (IaC) for a complete DevOps CI/CD pipeline, leveraging various tools such as Terraform, SonarQube, Aqua Trivy, and AWS services. The primary goal is to facilitate consistent and secure deployment of static websites on AWS S3 with Docker container orchestration via EC2.

## Architecture
The pipeline integrates several DevOps tools and practices to create a streamlined process from code commit to deployment:

- **Version Control**: Utilizes GitHub Actions as a replacement for Jenkins to automate the pipeline's workflows.
- **IaC**: Terraform scripts for provisioning and managing AWS resources.
- **Static Code Analysis**: SonarQube for code quality checks, coupled with Aqua Trivy for both code and dependency scanning.
- **Containerization**: Docker to containerize applications, ensuring consistent environments from development to production.
- **Hosting**: Static website hosting on AWS S3, with an EC2 instance to run Docker containers for applications.

![CI/CD Pipeline Architecture](aws-cicd-pipeline.jpg)

## Features
- **Automated Workflows**: Fully automated pipeline from code push to deployment, including build, test, and deploy stages.
- **Security Scanning**: Integrated security scanning to catch vulnerabilities early in the development cycle.
- **Infrastructure Management**: Terraform-managed infrastructure ensures environment consistency and reproducibility.
- **Scalability**: Easily scalable architecture to meet increasing traffic demands.
- **Cost-Efficiency**: Use of S3 for static hosting and EC2 for containerized apps optimizes cost.

## Prerequisites
- AWS Account
- Terraform installed
- Docker installed
- SonarQube account (optional for local setup)

## Usage
Detailed instructions on how to use the pipeline from setting up the infrastructure to deploying a static website.

### Setup
1. **AWS Credentials**: Configure your AWS credentials for Terraform.
2. **Terraform Initiation**: Run `terraform init` to initialize the Terraform environment.
3. **Code Analysis**: Set up GitHub Actions to trigger SonarQube and Aqua Trivy scans on code push.
4. **Terraform Planning**: Run `terraform plan` to preview infrastructure changes.

### Deployment
1. **Terraform Apply**: Execute `terraform apply` to provision the AWS infrastructure.
2. **Build and Push**: Use GitHub Actions to build the Docker image and push it to Amazon ECR.
3. **Run Container**: Launch the Docker container on an EC2 instance.
4. **Static Website**: Deploy the static content to S3 bucket and configure it for web hosting.

## Continuous Integration and Continuous Deployment (CI/CD)
A step-by-step guide on how the CI/CD process is orchestrated using this pipeline.

## Security
An overview of the security measures implemented through SonarQube and Aqua Trivy scans.

## Monitoring & Logging
Information on AWS CloudWatch integration for monitoring and logging the infrastructure and application performance.

## Contributing
Guidelines for contributing to the project, including coding standards, commit message formatting, and contact information.

## License
State the type of license this project is released under.

## Acknowledgments
Credit any third-party resources or contributors.

---



Designed and created a portfolio website, implemented Docker for consistent environment setup and GitHub Actions for automated CI/CD, ensuring seamless updates and functionality.

Live website

Terraform
Infrastructure as Code:
Setting Up AWS with Terraform
Using Terraform for setting up AWS infrastructure was both challenging and rewarding. It allowed me to define my infrastructure in code form, making it easy to track. I used Terraform scripts to create an EC2 instance, which serves as the backbone of my website hosting.

Features of the AWS Setup
In AWS, I meticulously configured an auto-scaling group to ensure that the website could handle varying loads by automatically adjusting resources. I also utilised two availability zones for increased reliability. The load balancer was key in managing incoming traffic efficiently, while the public subnets and an internet gateway were crucial for connecting my website to the wider internet. This robust setup provided a reliable and scalable foundation for my website.

AWS Infrastructure Diagram
