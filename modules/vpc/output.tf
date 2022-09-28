output "vpc_id" {
  value = aws_vpc.an_vpc.id
}

output "subnet-1" {
  value = aws_subnet.public_subnet_1.id
}

output "subnet-2" {
  value = aws_subnet.private_subnet_1.id
}

output "subnet-3" {
  value = aws_subnet.private_subnet_2.id
}