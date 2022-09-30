

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    "Name" = "MyFirstVPC"
  }
}

resource "aws_internet_gateway" "igw" {
vpc_id = aws_vpc.myvpc.id
tags = {
  "Name" = "igw"
} 
}

/*resource "aws_internet_gateway_attachment" "gw-attach" {
  internet_gateway_id = aws_internet_gateway.igw.id
  vpc_id              = aws_vpc.myvpc.id
}*/




resource "aws_eip" "eip" {
  vpc      = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_b.id

  tags = {
    Name = "my nat gw"
  }
  depends_on = [aws_internet_gateway.igw]
}



resource "aws_route_table" "rt_pub" {
  vpc_id = aws_vpc.myvpc.id
  #route {
    #cidr_block = "0.0.0.0/24"
    #gateway_id = aws_internet_gateway.igw.id
  #}
  tags = {
    Name = "rt-pub"
  }
}

resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.rt_pub.id
}

resource "aws_route_table_association" "public-b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.rt_pub.id
}
resource "aws_route_table" "rt_pri" {
  vpc_id = aws_vpc.myvpc.id
  #route {
    #cidr_block = "0.0.0.0/24"
    #nat_gateway_id = aws_nat_gateway.nat.id
  #}
  tags = {
    Name = "rt-pri"
  }
}

resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.rt_pri.id
}

resource "aws_route_table_association" "private-b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.rt_pri.id
}

resource "aws_route" "Public-igw" {
  route_table_id            = aws_route_table.rt_pub.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.igw.id
}

resource "aws_route" "Private-natgw" {
  route_table_id            = aws_route_table.rt_pri.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.nat.id
}