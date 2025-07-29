# 📦 lesson-8-9 — AWS Infrastructure with Terraform

This project sets up a complete AWS infrastructure using **Terraform**, including the following components:

- 🪣 S3 & DynamoDB backend for managing Terraform state
- 🌐 VPC with public and private subnets
- 📦 ECR repository for Docker images
- ☸️ EKS Kubernetes cluster
- ⚙️ Jenkins for CI/CD
- 🚀 Argo CD for GitOps-based deployment

---

## 📁 Project Structure

lesson-8-9/
├── main.tf                 # Main entry point for Terraform modules
├── backend.tf              # S3 + DynamoDB backend config
├── outputs.tf              # General resource outputs
├── modules/
│   ├── s3-backend/
│   │   ├── s3.tf
│   │   ├── dynamodb.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── vpc/
│   │   ├── vpc.tf
│   │   ├── routes.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ecr/
│   │   ├── ecr.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── eks/
│   │   ├── eks.tf
│   │   ├── aws_ebs_csi_driver.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── jenkins/
│   │   ├── jenkins.tf
│   │   ├── variables.tf
│   │   ├── providers.tf
│   │   ├── values.yaml
│   │   └── outputs.tf
│   └── argo_cd/
│       ├── argo.tf
│       ├── variables.tf
│       ├── providers.tf
│       ├── values.yaml
│       ├── outputs.tf
│       └── charts/
│           ├── Chart.yaml
│           ├── values.yaml
│           └── templates/
│               ├── application.yaml
│               └── repository.yaml
│           └── charts/
│               └── django-app/
│                   ├── Chart.yaml
│                   ├── values.yaml
│                   └── templates/
│                       ├── deployment.yaml
│                       ├── service.yaml
│                       ├── configmap.yaml
│                       ├── hpa.yaml
│                       ├── postgres-deployment.yaml
│                       ├── postgres-service.yaml
│                       └── postgres-pvc.yaml



---

## 📁 Project Structure


---

## 🔧 Terraform Modules Overview

### 1. 📂 **S3 + DynamoDB** (`modules/s3-backend`)
- Creates an **S3 bucket** to store `terraform.tfstate`
- Enables **versioning** on the bucket
- Creates a **DynamoDB table** for state locking  
  **Outputs:**
- S3 bucket name
- DynamoDB table name

---

### 2. 🌐 **VPC** (`modules/vpc`)
- Provisions a **VPC** with configurable CIDR
- Creates **3 public** and **3 private subnets**
- Adds an **Internet Gateway** and a **NAT Gateway**
- Configures route tables:
  - Public → IGW
  - Private → NAT  
    **Outputs:**
- VPC ID
- Subnet IDs
- IGW & NAT Gateway IDs

---

### 3. 🐳 **ECR** (`modules/ecr`)
- Creates an **ECR repository**
- Enables **image scanning on push**
- Sets an **access policy**  
  **Outputs:**
- ECR repository URL

---

### 4. ☸️ **EKS** (`modules/eks`)
- Provisions an **EKS cluster**
- Installs **AWS EBS CSI driver**  
  **Outputs:**
- kubeconfig
- Cluster name
- API endpoint

---

### 5. ⚙️ **Jenkins** (`modules/jenkins`)
- Installs Jenkins via **Helm**
- Configures Kubernetes agents (e.g., **Kaniko**)
- Jenkins pipeline:
  - Builds Docker image
  - Pushes image to ECR
  - Updates another repo’s `values.yaml`
  - Commits & pushes to `main`

---

### 6. 🚀 **Argo CD** (`modules/argo_cd`)
- Deploys Argo CD with **Helm**
- Includes:
  - `Application` and `Repository` resources
  - Auto-sync with Git to update Kubernetes state

---

## ⚙️ Getting Started

### ✅ Prerequisites

- [AWS CLI](https://aws.amazon.com/cli/) — configured with credentials and default region
- [Terraform](https://developer.hashicorp.com/terraform/install) — installed
- [`kubectl`](https://kubernetes.io/docs/tasks/tools/) — for managing Kubernetes
- [Helm](https://helm.sh/) — Kubernetes package manager

---

### ▶️ Steps

#### 1. Navigate to the project directory

```bash
cd lesson-8-9
```

#### 2. Initialize Terraform

```bash
terraform init
```

#### 3. Review the plan

```bash
terraform plan
```

#### 4. Apply the changes

```bash
terraform apply
```

#### 5. Destroy all resources (optional)

```bash
terraform destroy
```

---

## 🧩 Deploying the Django App via Helm

#### Navigate to the chart directory:
```bash
cd charts/django-app
```

#### Preview the installation:
```bash
helm install django-app . --dry-run --debug
```

#### Install the application:
```bash
helm install django-app .
```

#### Upgrade the application:
```bash
helm upgrade django-app .
```

#### Uninstall the application:
```bash
helm uninstall django-app
```

---