# Deployment Engineer Take-Home Project

## Overview

Imagine you want to publish a website on the internet that can handle thousands of visitors without crashing, automatically recovers if something goes wrong, and can be updated without any downtime. This project shows you exactly how to do that using modern cloud computing practices.

This repository is like a complete blueprint that automatically builds and manages a professional-grade web hosting environment on Amazon's cloud platform (AWS). While we use a simple "Hello World" webpage as an example, the same system can host complex business applications, e-commerce sites, or mobile app backends.

The project demonstrates three crucial modern technology practices: **Infrastructure as Code** (building cloud resources using written instructions rather than clicking through web interfaces), **Continuous Integration and Deployment** (automatically testing and deploying code changes), and **Container Orchestration** (managing applications in lightweight, portable packages that can run anywhere).

## What This Project Does

### Builds Cloud Infrastructure Automatically
Think of this like having a robot architect that can build an entire data center for your website. Instead of manually creating servers, networks, and security settings through Amazon's web interface (which could take hours and is prone to human error), this project uses **Terraform** - a tool that reads written instructions and automatically creates all the necessary cloud infrastructure. It builds a complete, production-ready hosting environment in about 10-15 minutes, including multiple servers, load balancers, and security configurations.

### Deploys and Manages Your Web Application
Once the infrastructure is ready, the project automatically installs your web application using **Helm Charts** - think of these as pre-packaged installation instructions that ensure your application is deployed consistently every time. The example uses Nginx (a powerful web server) to serve a simple "Hello World" page, but this same system can deploy complex databases, e-commerce platforms, or mobile app backends.

### Provides Bulletproof Automation
The entire process is orchestrated by **GitHub Actions**, which acts like a smart assistant that watches your code repository. Whenever you make changes, it automatically runs a series of tests, builds your infrastructure, deploys your application, and even performs health checks to ensure everything is working correctly. This eliminates the manual work typically required to deploy applications and reduces the chance of human error.

### Enables Professional-Grade Configuration Management
The project uses industry-standard tools to manage configurations and deployments. Helm charts allow you to easily customize your application settings (like how many server instances to run, which version to deploy, or environment-specific configurations) without modifying the core application code. This separation makes it easy to deploy the same application across different environments (development, testing, production) with different settings.

## Prerequisites

Before you can deploy this application, you'll need:

### Required Accounts and Access
1. **AWS Account** - You'll need access to Amazon Web Services with billing enabled
2. **GitHub Account** - To fork this repository and run the automation workflows
3. **AWS Credentials** - Access keys with administrative permissions to create cloud resources

### Technical Requirements
4. **Sufficient AWS Service Limits** - Ensure your AWS account can create:
   - EKS clusters (check your region's EKS service limits)
   - EC2 instances (at least 2 t3.medium instances)
   - VPC resources (subnets, internet gateways, NAT gateways)
   - Elastic Load Balancers
5. **Supported AWS Region** - This project works in most AWS regions, but verify EKS availability in your chosen region

### Financial Considerations
6. **AWS Budget Awareness** - Running this infrastructure will cost approximately $120-150/month
7. **Cost Monitoring Setup** - Consider setting up AWS billing alerts before deployment
8. **Cleanup Plan** - Have a plan to destroy resources when testing is complete to avoid ongoing charges

### Optional but Recommended
9. **Basic Command Line Familiarity** - While not required for the basic deployment, understanding terminal/command prompt helps with troubleshooting
10. **Git Knowledge** - Basic understanding of Git operations (clone, fork, commit) will help you customize the project

## Quick Start Guide

### Step 1: Setup AWS Credentials

1. Log into your AWS Console
2. Go to IAM (Identity and Access Management)
3. Create a new user with programmatic access
4. Attach the `AdministratorAccess` policy (for simplicity)
5. Save the **Access Key ID** and **Secret Access Key**

### Step 2: Configure GitHub Secrets

1. Go to your GitHub repository
2. Click on **Settings** → **Secrets and variables** → **Actions**
3. Add these repository secrets:
   - `AWS_ACCESS_KEY_ID`: Your AWS Access Key ID
   - `AWS_SECRET_ACCESS_KEY`: Your AWS Secret Access Key

### Step 3: Deploy the Application

1. Go to your GitHub repository
2. Click on the **Actions** tab
3. Find the "Deploy EKS Environment" workflow
4. Click **Run workflow** → **Run workflow**
5. Wait for the deployment to complete (typically 10-15 minutes)

### Step 4: Access Your Application

Once the workflow completes successfully:
1. Check the workflow logs for the application URL
2. Look for a message like: `✅ Smoke-test passed! Application is live at http://your-loadbalancer-url`
3. Open that URL in your browser to see your Hello World application. Just Like below
   
   <img src="images/output.jpg" alt="Job Status Check" style="width: 50%; max-width: 50px; height: auto;"></br>

## What Gets Created

### AWS Infrastructure
- **EKS Cluster**: A managed Kubernetes cluster in AWS
- **VPC**: Virtual Private Cloud with public and private subnets
- **Load Balancer**: Automatically created to expose your application to the internet
- **EC2 Instances**: Worker nodes where your application runs

### Application Components
- **Nginx Web Server**: Serves the Hello World content
- **Kubernetes Service**: Exposes the application via a Load Balancer
- **Kubernetes Deployment**: Manages the application pods with high availability

## Troubleshooting

### Common Issues

**Workflow Fails with AWS Permissions Error**
- Verify your AWS credentials are correctly set in GitHub Secrets
- Ensure your AWS user has sufficient permissions

**Application Not Accessible**
- Wait a few minutes for the Load Balancer to become ready
- Check the workflow logs for the correct URL
- Verify the Load Balancer was created in AWS Console

## Technical Details

### Architecture

This deployment creates a production-ready architecture:
- **High Availability**: Application runs across multiple availability zones
- **Scalability**: Can easily scale up/down based on demand
- **Security**: Private subnets for worker nodes, public subnets for load balancers
- **Monitoring**: Built-in AWS CloudWatch integration

### Technologies Used

- **Terraform**: Infrastructure as Code tool that transforms written configuration files into actual cloud resources. This approach ensures reproducible, version-controlled infrastructure that can be recreated identically across different environments
- **Helm Charts**: Kubernetes package manager that simplifies application deployment and configuration management. Our custom Helm chart demonstrates templating, value management, and deployment best practices
- **GitHub Actions**: Complete CI/CD pipeline implementation that automatically builds, tests, and deploys infrastructure and applications. Shows expertise in automation and continuous delivery practices
- **AWS EKS**: Amazon's managed Kubernetes service, demonstrating cloud-native orchestration and container management
- **Nginx**: Production-grade web server chosen for reliability and performance

## Security Best Practices

This project implements several security best practices:
- Worker nodes in private subnets
- IAM roles for service authentication
- Security groups for network access control
- Kubernetes RBAC for application permissions

## How to Clean Up

To avoid ongoing AWS costs, this project includes a separate, automated workflow to delete all the infrastructure that was created.

1.  Go to the **"Actions"** tab of this repository.
2.  On the left, select the **"Destroy EKS Environment"** workflow.
3.  Click the **"Run workflow"** button to start the cleanup process.

This will run `terraform destroy` and safely remove all the AWS resources.

## Project Structure

```
├── .github/workflows/
│   └── deploy.yml           # GitHub Actions CI/CD pipeline
├── helm-chart/              # Helm chart for the application
│   ├── Chart.yaml          # Chart metadata
│   ├── values.yaml         # Configuration values
│   └── templates/          # Kubernetes resource templates
│       ├── deployment.yaml # Application deployment
│       └── service.yaml    # Load balancer service
├── terraform/              # Infrastructure as Code
│   ├── main.tf            # Main infrastructure definition
│   ├── variables.tf       # Input variables
│   └── outputs.tf         # Output values
└── README.md              # This file
```
