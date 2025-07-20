output "vpc_id" {
  description = "Id of created VPC"
  value = aws_vpc.main.id
}

output "public_subnets" {
  description = "List of id of public subnets"
  value = aws_subnet.public[*].id

}

output "private_subnets" {
  description = "List of id of private subnets"
  value = aws_subnet.private[*].id
}


output "aws_internet_gateway_id" {
  description = "Id Internet Gateway"
  value = aws_internet_gateway.igw.id
}