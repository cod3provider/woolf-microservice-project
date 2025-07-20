variable "vpc_cidr_block" {
  description = "value of VPC CIDR block"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)

}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "availability_zones" {
  description = "Available zones"
  type        = list(string)

}
variable "vpc_name" {
  description = "Name of the vpc"
  type        = string

}