variable "name" {
  default = "ecs_task"
}

variable "region" {
  description = "us-east-2"
}

#variable "subnets" {
#  description = "List of subnet IDs"
#}

variable "vpc_id" {
  default = "module.vpc.vpc_id"
}

variable "subnet_id" {
   default = "module.vpc.public_subnet"
}

variable "subnet_id2" {
   default = "module.vpc.public_subnet2"
}

variable "ecs_service_security_groups" {
  default = "module.sg_alb_ecs.ecs_tasks"

}

variable "container_port" {
  default = "80"
}

variable "container_cpu" {
  default = "7"
}

variable "container_memory" {
  default = "2048"
}

variable "container_image" {
  default = "nginx"
}

variable "aws_alb_target_group_arn" {
  default = "module.alb.aws_alb_target_group_arn"
}

variable "service_desired_count" {
  default = "3"
}

