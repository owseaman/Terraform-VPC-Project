resource "aws_subnet" "private_a" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/26"
  map_public_ip_on_launch = false
  availability_zone = var.availability_zones[0]
  tags = {
    "Name" = "Private-sn-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.0.64/26"
  map_public_ip_on_launch = false
  availability_zone = var.availability_zones[1]
  tags = {
    "Name" = "Private-sn-b"
  }
}

resource "aws_subnet" "public_a" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.128/26"
    map_public_ip_on_launch = true 
    availability_zone = var.availability_zones[0]
    
  tags = {
      Name = "Public-sn-a"
    }
}

resource "aws_subnet" "public_b" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.192/26"
    map_public_ip_on_launch = true 
    availability_zone = var.availability_zones[1]
  tags = {
      Name = "Public-sn-b"
    }
}