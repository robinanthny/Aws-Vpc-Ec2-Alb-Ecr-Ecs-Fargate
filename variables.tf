variable "vpc_cidr" {
  default     = "10.0.0.0/16"
}

variable "subnet1_cidr" {
  default     = "10.0.0.0/24"
}

variable "subnet2_cidr" {
  default     = "10.0.1.0/24"
}

variable "amiid" {
   default = "ami-0fb653ca2d3203ac1"
}

variable "type" {
   default = "t2.micro"
}

variable "pemfile" {
   default = "devopskey"
}

variable "vpc_id" {
   default = "module.vpc.vpc_id"
   type = string
}
