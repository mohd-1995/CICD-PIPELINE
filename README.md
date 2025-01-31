# HTML-WEBSITE-CICD
Designed and created a portfolio website, implemented Docker for consistent environment setup and GitHub Actions for automated CI/CD, ensuring seamless updates and functionality.


[Live website](https://moesportfolio.com/)

## Terraform

### Infrastructure as Code:

#### Setting Up AWS with Terraform

Using Terraform for setting up AWS infrastructure was both challenging and rewarding. It allowed me to define my infrastructure in code form, making it easy to track. I used Terraform scripts to create an EC2 instance, which serves as the backbone of my website hosting.

#### Features of the AWS Setup

In AWS, I meticulously configured an auto-scaling group to ensure that the website could handle varying loads by automatically adjusting resources. I also utilised two availability zones for increased reliability. The load balancer was key in managing incoming traffic efficiently, while the public subnets and an internet gateway were crucial for connecting my website to the wider internet. This robust setup provided a reliable and scalable foundation for my website.

## AWS Infrastructure Diagram

![AWS Diagram](/AWS-Structure.png)
changes made - t2.micro ---> nano 
AWS ALB removed and nginx reverse proxy added due to the low traffic website