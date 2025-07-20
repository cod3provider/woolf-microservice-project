output "s3_bucket_name" {
  description = "Name of S3-bucket for states"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "dynamodb_table_name" {
  description = "Name of the table DynamoDB for lock states"
  value       = aws_dynamodb_table.terraform_locks.name
}