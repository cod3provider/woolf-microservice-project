output "repository_url" {
  description = "Url of the ERC repository"
  value       =  aws_ecr_repository.erc_repo.repository_url
}