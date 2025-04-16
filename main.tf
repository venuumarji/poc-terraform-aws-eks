module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  availability_zones   = var.availability_zones
  cluster_name         = var.cluster_name
  tags                 = var.tags
}

module "keypair" {
  source     = "./modules/keypair"
  key_name   = "${var.environment}-eks-key"
  ssm_prefix = "/${var.environment}/keypair"
  tags       = var.tags
}

module "eks" {
  source            = "./modules/eks"
  cluster_name      = var.cluster_name
  cluster_version   = var.cluster_version
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.public_subnet_ids
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  disk_size         = var.disk_size
  min_size          = var.min_size
  max_size          = var.max_size
  desired_capacity  = var.desired_capacity
  key_name          = module.keypair.key_name
  tags              = var.tags
}



