module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "${var.project_name}-${var.target_label}-vpc"

  cidr = var.vpc_cidr

  azs = var.azs

  public_subnets = var.public_cidr

  map_public_ip_on_launch = true

  create_igw = true
}