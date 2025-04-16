variable "region" {}
variable "environment" {}
variable "cluster_name" {}
variable "cluster_version" {}
variable "ami_id" {}
variable "instance_type" {}
variable "disk_size" {
  default = 20
}
variable "min_size" {}
variable "max_size" {}
variable "desired_capacity" {}
variable "vpc_cidr" {}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "availability_zones" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}


