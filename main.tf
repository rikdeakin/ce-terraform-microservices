module "networking" {
  source = "./modules/networking"
  vpc_name           = "${var.project_name}_vpc"
  cidr_range         = "10.0.0.0/20"
  availability_zones = ["eu-west-2a", "eu-west-2b"]
  public_subnets     = ["10.0.0.0/24"]
  private_subnets    = ["10.0.10.0/24"]
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

module "instances" {
  source                      = "./modules/instances"
  vpc_id                      = module.networking.vpc_id
  instance_count              = 4
  security_group_ids          = [module.security.private_sg_id, module.security.public_sg_id, module.security.public_sg_id, module.security.public_sg_id]
  subnet_ids                  = [module.networking.private_subnet, module.networking.public_subnet, module.networking.public_subnet, module.networking.public_subnet]
  associate_public_ip_address = [false, true, true, true]
  instance_names              = ["auth-server", "status-server", "heating-server", "lighting-server"]
  ami_name                    = var.ami_name
  ami_id                      = var.ami_id
  ami_key_pair_name           = var.ami_key_pair_name
}