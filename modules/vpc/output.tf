output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "public_access_sg_id" {
  description = "Security group ID that allows SSH, HTTP, and HTTPS"
  value       = aws_security_group.public_access_sg.id
}