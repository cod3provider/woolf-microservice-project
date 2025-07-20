variable "repository_name" {
  description = "The name of the ECR repository"
  type = string
}
variable "scan_on_push" {
  description = "The flag scan on push"
  type = bool
}