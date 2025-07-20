# Terraform AWS Infrastructure — Lesson 5

## Модулі

- **s3-backend**: Створює S3-бакет із версіюванням для Terraform state і DynamoDB для блокування.
- **vpc**: Створює VPC, 3 публічні підмережі, 3 приватні підмережі, Internet Gateway, NAT Gateway, маршрути.
- **ecr**: Створює репозиторій ECR для зберігання Docker-образів.

## Команди для запуску

```bash
terraform init
terraform plan
terraform apply
terraform destroy