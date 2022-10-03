resource "aws_security_group" "my_sg" {
  name        = "my_sg"
  description = "Allow inbound traffic from web"
  vpc_id      = aws_vpc.myvpc.id
  depends_on = [
    aws_vpc.myvpc
  ]

  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
    from_port   = port.value
    to_port     = port.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }

 dynamic "egress" {
    iterator = port
    for_each = var.egressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
  tags = {
    Name = "my_sg"
  }
}
