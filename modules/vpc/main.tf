# ----------------------------
# CONFIGURE  AWS CONNECTION
# ----------------------------

provider "aws" {
  region = "us-east-2"
}

#--------------
# Create a VPC
#--------------

resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "DEMO VPC"
  }
}

# --------------------------------------------------------
# GET THE LIST OF AVAILABILITY ZONES IN THE CURRENT REGION
# --------------------------------------------------------
data "aws_availability_zones" "all" {}


#-------------------------------------------------
# Create a Public subnet on the First available AZ
#-------------------------------------------------

resource "aws_subnet" "public_us_east_2a" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet1_cidr
  availability_zone = data.aws_availability_zones.all.names[0]

  tags = {
    Name = "Public Subnet"
  }
}

#-------------------------------------------------
# Create a Public subnet on the Third available AZ
#-------------------------------------------------

resource "aws_subnet" "public_us_east_2c" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet3_cidr
  availability_zone = data.aws_availability_zones.all.names[2]

  tags = {
    Name = "Public Subnet2"
  }
}

#-------------------------------
# Create an IGW for your new VPC
#-------------------------------
resource "aws_internet_gateway" "my_vpc_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "DEMO IGW" 
  }
}

#----------------------------------
# Create an RouteTable for your VPC
#----------------------------------
resource "aws_route_table" "my_vpc_public" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_vpc_igw.id
    }

    tags = {
        Name = "DEMO Public RouteTable"
    }
}

#--------------------------------------------------------------
# Associate the RouteTable to the Subnet created at public_us_east_2a
#--------------------------------------------------------------
resource "aws_route_table_association" "my_vpc_public_us_east_2a" {
    subnet_id = aws_subnet.public_us_east_2a.id
    route_table_id = aws_route_table.my_vpc_public.id
}

#--------------------------------------------------------------
# Associate the RouteTable to the Subnet created at public_us_east_2c
#--------------------------------------------------------------
resource "aws_route_table_association" "my_vpc_public_us_east_2c" {
    subnet_id = aws_subnet.public_us_east_2c.id
    route_table_id = aws_route_table.my_vpc_public.id
}
#-----------------------------------------------------------
#---------------------------------------------------
resource "aws_subnet" "private_us_east_2b" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet2_cidr
  availability_zone = data.aws_availability_zones.all.names[1]

  tags = {
    Name = "Private Subnet"
  }
}
#=========================================================================
# Creating Elastic Ip for the nat instance
#=========================================================================
resource "aws_eip" "nat" {
    vpc      = true
}
#
#
#=========================================================================
# Creating Nat GateWay
#=========================================================================

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_us_east_2a.id 
}
#---------------------------------
# Create an RouteTable for Private
#---------------------------------
resource "aws_route_table" "my_vpc_private" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
         nat_gateway_id = aws_nat_gateway.nat.id
#        instance_id = aws_route_table.my_vpc_private.id
    }

    tags = {
        Name = "DEMO Private RouteTable"
    }
}
#
#----------------------------------------------------------------
# Associate the DB RouteTable to the Subnet created at us-east-2b
#----------------------------------------------------------------
resource "aws_route_table_association" "my_vpc_us_east_2b_private" {
    subnet_id = aws_subnet.private_us_east_2b.id
    route_table_id = aws_route_table.my_vpc_private.id
}
#
