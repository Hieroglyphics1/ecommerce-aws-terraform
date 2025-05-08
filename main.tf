terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "ecommerce-tfstate-unique-name"
    key          = "global/s3/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Ecommerce Platform"
      Environment = var.environment
      Terraform   = "true"
    }
  }
}

# Llamada a los módulos
module "networking" {
  source               = "./modules/networking"
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "database" {
  source             = "./modules/database"
  environment        = var.environment
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  security_group_ids = [module.networking.db_security_group_id]
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
}

module "caching" {
  source             = "./modules/caching"
  environment        = var.environment
  vpc_id             = module.networking.vpc_id
  subnet_ids         = module.networking.private_subnet_ids
  security_group_ids = [module.networking.cache_security_group_id]
  node_type          = "cache.t3.small" # Ajusta según necesidades
}

module "compute" {
  source             = "./modules/compute"
  environment        = var.environment
  vpc_id             = module.networking.vpc_id
  subnet_ids         = module.networking.private_subnet_ids
  security_group_ids = [module.networking.app_security_group_id]
  instance_type      = "t3.medium" # Ajusta según necesidades
  db_endpoint        = module.database.endpoint
  cache_endpoint     = module.caching.endpoint
  key_name           = var.key_name
}

module "frontend" {
  source      = "./modules/frontend"
  environment = var.environment
  domain_name = var.domain_name # Opcional: Si tienes un dominio
  bucket_name = "static-assets-${var.environment}"
}

module "monitoring" {
  source             = "./modules/monitoring"
  environment        = var.environment
  alb_arn            = module.compute.alb_arn
  redis_cluster_id   = module.caching.redis_cluster_id
  db_cluster_id      = module.database.cluster_id
  notification_email = "pruebas@gmail.com"
}