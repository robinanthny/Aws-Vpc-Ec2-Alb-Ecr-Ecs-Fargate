#-----------------------------------------------------------
# CREATE THE SECURITY GROUP THAT'S APPLIED TO Web Server EC2 
#-----------------------------------------------------------
provider "aws" {
  region = "us-east-2"
}
resource "aws_security_group" "instance" {
  name = "sginstance"
  vpc_id = var.vpc_id
#  vpc_id =  module.vpc.aws_vpc.my_vpc.id
#  vpc_id =  module.vpc.vpc_id
  # Allow all outbound 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound for SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Inbound for Web server
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#------------------
# Create EC2 Server
#------------------
resource "aws_instance" "server" {
   ami           = var.amiid
   instance_type = var.type
   key_name      = var.pemfile
   vpc_security_group_ids = [aws_security_group.instance.id]
   #subnet_id = module.vpc.public_subnet
   #subnet_id = module.vpc.aws_subnet.public_us_east_2a.id
   subnet_id =  var.subnet_id
#   availability_zone = module.vpc.data.aws_availability_zones.all.names[0]
   
   associate_public_ip_address = true
   
   user_data = <<-EOF
               #!/bin/bash
                sudo apt-get update
                sudo apt-get install apache2 -y
               echo '<html><body><h1 style="font-size:50px;color:blue;">Rainbow<br> <font style="color:red;"> www.wezva.com <br> <font style="color:green;">  </h1> </body></html>' > index.html
#               nohup busybox httpd -f -p 8080 &
              EOF

    tags = {
        Name = "Web Server"
    }
  
}

#----------------------------------------------------------
# CREATE THE SECURITY GROUP THAT'S APPLIED TO DB Server EC2
#----------------------------------------------------------
resource "aws_security_group" "db" {
  name = "example-db"
#  vpc_id = module.vpc.aws_vpc.my_vpc.id 
#  vpc_id = module.vpc.vpc_id 
  vpc_id = var.vpc_id 

  # Allow all outbound 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound for SSH
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
#   security_groups = [aws_security_group.instance.id]
  }
  
}

#---------------------
# Create EC2 DB Server
#---------------------
#resource "aws_instance" "db" {
#   ami           = var.amiid
#   instance_type = var.type
#   key_name      = var.pemfile
#   vpc_security_group_ids = [aws_security_group.db.id]
#   subnet_id = module.vpc.privatesubnet
#   availability_zone = module.vpc.availablityzone_private
#   
#   associate_public_ip_address = true
#
#   tags = {
#       Name = "DB Server"
#   }
#  
#}

