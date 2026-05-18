provider "aws" {
  region = var.aws_region
}

# -----------------------------
# VPC Module
# -----------------------------
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr

  public_subnet_cidr_1 = var.public_subnet_cidr_1
  public_subnet_cidr_2 = var.public_subnet_cidr_2

  availability_zone_1  = var.availability_zone_1
  availability_zone_2  = var.availability_zone_2
}

# -----------------------------
# EC2 Module
# -----------------------------
module "ec2" {
  source = "./modules/ec2"

  vpc_id    = module.vpc.vpc_id

  # Launch EC2 in first public subnet
  subnet_id = module.vpc.public_subnet_1_id

  ami_id         = var.ami_id
  instance_type  = var.instance_type

  key_name       = var.key_name
  public_key_path = var.public_key_path
}

# -----------------------------
# ALB Module
# -----------------------------
module "alb" {
  source = "./modules/alb"

  vpc_id = module.vpc.vpc_id

  subnet_ids = [
    module.vpc.public_subnet_1_id,
    module.vpc.public_subnet_2_id
  ]

  instance_id = module.ec2.instance_id
}

# -----------------------------
# Route53 Module
# -----------------------------
module "route53" {
  source = "./modules/route53"

  domain_name = var.domain_name

  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}