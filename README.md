# lesson-7 — AWS Infrastructure with Terraform

This project provisions an AWS infrastructure using **Terraform**, including:  
S3 & DynamoDB backend for state management  
VPC with public & private subnets  
ECR repository for Docker images
EKS Kubernetes cluster

---

##  Project Structure

lesson-7/
├── main.tf                  # Main file to include all modules
├── backend.tf               # Backend configuration for state (S3 + DynamoDB)
├── outputs.tf               # Outputs from resources
├── modules/                 # Directory containing all modules
│   ├── s3-backend/          # Module for S3 and DynamoDB
│   │   ├── s3.tf            # Create S3 bucket
│   │   ├── dynamodb.tf      # Create DynamoDB table
│   │   ├── variables.tf     # Variables for S3 backend
│   │   └── outputs.tf       # Outputs for S3 and DynamoDB
│   ├── vpc/                 # VPC module
│   │   ├── vpc.tf           # Create VPC, subnets, Internet Gateway
│   │   ├── routes.tf        # Routing configuration
│   │   ├── variables.tf     # Variables for VPC
│   │   └── outputs.tf       # Outputs for VPC resources
│   ├── ecr/                 # ECR module
│   │   ├── ecr.tf           # Create ECR repository
│   │   ├── variables.tf     # Variables for ECR
│   │   └── outputs.tf       # Output repository URL
│   ├── eks/                 # EKS Kubernetes cluster module
│   │   ├── eks.tf           # Create EKS cluster
│   │   ├── variables.tf     # Variables for EKS
│   │   └── outputs.tf       # Outputs for cluster info
├── charts/
│   └── django-app/
│       ├── templates/
│       │   ├── deployment.yaml
│       │   ├── postgres-deployment.yaml
│       │   ├── service.yaml
│       │   ├── postgres-service.yaml
│       │   ├── postgres-pvc.yaml
│       │   ├── configmap.yaml
│       │   └── hpa.yaml
│       ├── Chart.yaml
│       └── values.yaml      # Parameters for image, service, autoscale, config




---

## 📦 Modules

### 1 S3 + DynamoDB (`modules/s3-backend`)
- Creates an **S3 bucket** to store the `terraform.tfstate`.
- Enables **versioning** on the bucket.
- Creates a **DynamoDB table** to handle state locking.
- Outputs:
    - S3 bucket name.
    - DynamoDB table name.

---

### 2 VPC (`modules/vpc`)
- Creates a **VPC** with a specified CIDR block.
- Creates **3 public** and **3 private subnets**.
- Creates an **Internet Gateway** for public subnets.
- Creates a **NAT Gateway** for private subnets.
- Configures route tables:
    - Public subnets → IGW.
    - Private subnets → NAT Gateway.
- Outputs:
    - VPC ID.
    - Subnet IDs.
    - IGW & NAT IDs.

---

### 3 ECR (`modules/ecr`)
- Creates an **ECR repository**.
- Enables **image scanning on push**.
- Sets an **access policy** for the repository.
- Outputs:
    - ECR repository URL.

### 4. EKS (modules/eks)
Creates an EKS Kubernetes cluster.

Outputs cluster connection info (endpoint, kubeconfig).


---

##  Getting Started

###  Prerequisites
- [AWS CLI](https://aws.amazon.com/cli/) — configured with credentials and default region.
- [Terraform](https://developer.hashicorp.com/terraform/install) — installed locally.
- kubectl — for Kubernetes cluster management.
- Helm — package manager for Kubernetes.
---

###  Steps

## Navigate to the project directory:
bash
cd lesson-7

## Initialize Terraform
terraform init

## Review the plan
terraform plan

## Apply the changes

terraform apply


## To destroy all resources
terraform destroy

# To deploy app

## Navigate to the Helm chart directory
cd charts/django-app

## Preview the installation (dry-run)
helm install django-app . --dry-run --debug

## Install the application
helm install django-app .

## Upgrade the application (when chart changes)
helm upgrade django-app .

## Uninstall the application
helm uninstall django-app