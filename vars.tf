variable "instance_type" {
description = "The type of aws instance"
    type = list(string)
    default = ["t2.micro" , "t2.medium"]
}

/*variable "my_ami" {
    description = "The ami to run"
    type = string
    default = "ami-0f924dc71d44d23e2"
}
*/
variable "key_pair" {
    description = "my ec2 key"
    type = string
    default = "lb"
}   

variable "public_subnet_id" {
    description = "the public subnets"
    type = list(string)
    default = ["aws_subnet.public_a.id" , "aws_subnet.public_b.id"]
}
variable "private_subnet_id" {
    description = "the private subnets"
    type = list(string)
    default = ["aws_subnet.Private-a.id" , "aws_subnet.Private-b.id"]
}

variable "nat-gw" {
    description = "the nat gateway"
    type = string
    default = "aws_nat_gateway.nat"
}
variable "availability_zones" {
    description = "the subnet availability zones"
    type = list(string)
    default =["us-east-1a" , "us-east-1b"]
}
