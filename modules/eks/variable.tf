variable "cluster_name" {}
variable "cluster_version" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "ami_id" {}
variable "instance_type" {}
variable "disk_size" {
  default = 20
}
variable "min_size" {}
variable "max_size" {}
variable "desired_capacity" {}
variable "key_name" {}
variable "tags" {
  type = map(string)
}
