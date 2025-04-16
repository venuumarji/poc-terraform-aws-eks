resource "tls_private_key" "eks" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_ssm_parameter" "private_key" {
  name        = "${var.ssm_prefix}/private"
  type        = "SecureString"
  value       = tls_private_key.eks.private_key_pem
  #overwrite   = true
  description = "Private key for EC2 access"
}

resource "aws_ssm_parameter" "public_key" {
  name        = "${var.ssm_prefix}/public"
  type        = "String"
  value       = tls_private_key.eks.public_key_openssh
  #overwrite   = true
  description = "Public key for EC2 access"
}
