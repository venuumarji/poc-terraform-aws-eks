output "public_key_ssm_path" {
  value = aws_ssm_parameter.public_key.name
}

output "key_name" {
  value = var.key_name
}

output "public_key_value" {
  value = tls_private_key.eks.public_key_openssh
}
