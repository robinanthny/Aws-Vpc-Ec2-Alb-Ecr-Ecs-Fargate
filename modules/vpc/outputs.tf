output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

#output "instance_id" {
#  value = aws_instance.server.id
#}

output "public_subnet" {
  value = aws_subnet.public_us_east_2a.id
}

output "public_subnet2" {
  value = aws_subnet.public_us_east_2c.id
}

output "availabilityzone" {
  value = data.aws_availability_zones.all.names[0]
}

output "privatesubnet" {
  value = aws_subnet.private_us_east_2b.id
}
output "availablityzone_private" {
  value = data.aws_availability_zones.all.names[1]
}
