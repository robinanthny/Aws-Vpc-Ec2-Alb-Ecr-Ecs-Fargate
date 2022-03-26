provider "aws" {
  region = "us-east-2"
}
#Module Vpc
module "vpc" {
  source = "./modules/vpc"
}

#Module Ec2 
module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet
}

#Module Security Group Alb
module "sgalb" {
  source = "./modules/sg_alb_ecs"
  vpc_id = module.vpc.vpc_id
#  subnet_id = module.vpc.public_subnet
}

#Module ALB
module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet
  subnet_id2 = module.vpc.public_subnet2
  alb = module.sgalb.alb
#  ecs_tasks = module.sg_alb_ecs.ecs_tasks
}
#Module ECR
module "ecr" {
  source = "./modules/ecr"
#  vpc_id = module.vpc.vpc_id
}
#Module ECS
module "ecs" {
  source = "./modules/ecs"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet
  subnet_id2 = module.vpc.public_subnet2
  region = "us-east-2"
#  alb = module.sgalb.alb
#  ecs_tasks = module.sg_alb_ecs.ecs_tasks
  aws_alb_target_group_arn = module.alb.aws_alb_target_group_arn
}
