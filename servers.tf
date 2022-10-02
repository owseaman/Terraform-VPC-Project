resource "aws_instance" "My_First_ec2"{
  ami = data.aws_ami.amazonlinux2.id
  #instance_type = var.instance_type[0]
  instance_type = var.instance_type_map["prod"]
  subnet_id = aws_subnet.private_a.id
  #vpc_security_group_ids = ["aws_security_group.my_sg.id"]
  key_name = var.key_pair
  user_data = "${file("tomcat.sh")}"
  count = 3 

  tags = {
    #"Name" = "tomcat"
    "Name" = "tomcat-${count.index}"
  }
}


resource "aws_instance" "My_JumpServer"{
  ami = data.aws_ami.amazonlinux2.id
  #instance_type = var.instance_type[1]
  instance_type = var.instance_type_map["staging"]
  subnet_id = aws_subnet.public_a.id
  #vpc_security_group_ids = ["aws_security_group.my_sg.id"]
  key_name = var.key_pair
  depends_on = [aws_internet_gateway.igw]
  count = 2

  tags = {
    "Name" = "JumpServer-${count.index}"
  }
}
