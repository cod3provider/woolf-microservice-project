output "db_endpoint" {
  description = "Primary database endpoint (RDS or Aurora writer)"
  value       = var.use_aurora ? aws_rds_cluster.aurora[0].endpoint : aws_db_instance.standard[0].endpoint
}

output "db_name" {
  description = "Database name"
  value       = var.db_name
}

output "security_group_id" {
  description = "ID of the security group used by RDS"
  value       = aws_security_group.rds.id
}

output "subnet_group_name" {
  description = "Name of the DB subnet group"
  value       = aws_db_subnet_group.default.name
}