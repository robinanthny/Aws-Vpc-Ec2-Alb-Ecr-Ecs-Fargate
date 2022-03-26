variable "name" {
   default = "demo"
}

variable "vpc_id" {
   default = "module.vpc.vpc_id"
}

variable "container_port" {
   default = "80"
}
