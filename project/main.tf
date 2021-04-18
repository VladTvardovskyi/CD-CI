provider "aws" {
  region = "eu-central-1"
}

# terraform {
#   backend "s3" {
#     bucket         = "rude-name-for-terraform-bucket-s3"
#     key            = "history/terraform.tfstate"
#     region         = "eu-central-1"
#     dynamodb_table = "terraform-up"
#     encrypt        = true
#   }
# }

#Create our network
module "vpc" {
  source              = "../modules/aws-vpc"
  cidr_vpc            = "10.0.0.0/16"
  cidr_subnet_public  = "10.0.1.0/24"
  cidr_subnet_private = "10.0.4.0/24"
}
#Create Template Security group
module "secure_group" {
  source              = "../modules/aws-sg"
  namespace           = "Web_sg"
  stage               = "dev"
  name                = "WebServer"
  tcp_ports           = "80,443,22"
  cidrs               = ["0.0.0.0/0"]
  security_group_name = "Web"
}

#Create RDS MySQL

module "rds-mysql" {
  source                    = "../modules/aws-rds-postgre"
  namespace                 = "backend"
  stage                     = "dev"
  name                      = "oms2"
  rds-name                  = "oms2"
  final-snapshot-identifier = "oms-ca-db-final-snap-shot"
  skip-final-snapshot       = "true"
  rds-allocated-storage     = "5"
  storage-type              = "gp2"
  rds-engine                = "mysql"
  engine-version            = "8.0"
  db-instance-class         = "db.t2.micro"
  backup-retension-period   = "0"
  backup-window             = "04:00-06:00"
  publicly-accessible       = "true"
  rds-username              = "worker"
  rds-password              = var.rds-secret
  multi-az                  = "true"
  storage-encrypted         = "false"
  deletion-protection       = "false"
  # vpc-security-group-ids    = [module.sg2.aws_security_group_default]
  # subnet_ids                = module.vpc.aws_subnet.private_1
}

# module "s3" {
#   source = "../modules/s3-backend"
# }
module "eks_demo" {
  source = "../modules/eks-demo"
}
