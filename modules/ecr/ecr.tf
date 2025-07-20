resource "aws_ecr_repository" "erc_repo" {
  name = var.repository_name
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}


resource "aws_ecr_repository_policy" "ecr_repo_policy" {
  repository = aws_ecr_repository.erc_repo.name

  policy = jsonencode({
    Version = "2008-10-17",
    Statement = [
      {
        Sid       = "AllowPull"
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
      }
    ]
  })
}