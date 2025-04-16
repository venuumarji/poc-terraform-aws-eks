region              = "us-west-2"
environment         = "dev"
cluster_name        = "dev-eks-cluster"
cluster_version     = "1.31"
ami_id              = "ami-04fe8f90ca037b7b0" # EKS Optimized AMI for us-west-2
instance_type       = "t2.micro"
disk_size           = 20
min_size            = 1
max_size            = 3
desired_capacity    = 2
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones  = ["us-west-2a", "us-west-2b"]
tags = {
  Environment = "dev"
  Project     = "eks"
  Owner       = "dev-team"
}
