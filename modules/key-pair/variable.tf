variable "key_name" {
  type        = string
  description = "Name of the EC2 key pair"
}

variable "ssm_prefix" {
  type        = string
  description = "SSM parameter prefix"
}

variable "tags" {
  type        = map(string)
  default     = {}
}
