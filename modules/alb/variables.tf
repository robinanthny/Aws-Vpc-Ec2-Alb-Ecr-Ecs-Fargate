variable "name" {
  description = "the name of your stack, e.g. \"demo\""
  default = "demoalb"
}

#variable "environment" {
#  description = "the name of your environment, e.g. \"prod\""
#}

variable "subnet_id" {
#  description = "Comma separated list of subnet IDs"
   default = "module.vpc.public_subnet"
}

variable "subnet_id2" {
   default = "module.vpc.public_subnet2"
}

variable "vpc_id" {
  default = "module.vpc.vpc_id"
}

variable "alb" {
#  description = "Comma separated list of security groups"
   default  = "module.sgalb.alb"
}

variable "alb_tls_cert_arn" {
   default = "arn:aws:acm:us-east-2:332395446525:certificate/67706f47-ddb1-49e8-9c7b-a9435a6f7387"
}

#variable "health_check_path" {
#  description = "Path to check if the service is healthy, e.g. \"/status\""
#}
