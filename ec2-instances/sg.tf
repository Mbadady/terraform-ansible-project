resource "aws_security_group" "ssh-access" {
  name        = "allow_ssh_access"
  description = "Allow port 22 inbound traffic"
  vpc_id      = aws_vpc.my_assignment_vpc.id

  ingress {
    
    description      = "TLS from VPC"
    from_port        = var.inbound_ports
    to_port          = var.inbound_ports
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "altschoolAssignment-sg"
  }
}

resource "aws_security_group" "elb_sg" {
  name        = "lb-sg"
  description = "lb-sg"
  vpc_id      = aws_vpc.my_assignment_vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = "${var.inbound_ports_alb[0]}"
    to_port          = "${var.inbound_ports_alb[0]}"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
ingress {
    description      = "TLS from VPC"
    from_port        = "${var.inbound_ports_alb[1]}"
    to_port          = "${var.inbound_ports_alb[1]}"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "altschoolAssignment-el-sg"
  }
}


# resource "aws_security_group" "elb_sg_https" {
#   name        = "allow-port-443"
#   description = "allow_port_443"
#   vpc_id      = aws_vpc.my_assignment_vpc.id

#   ingress {
#     description      = "TLS from VPC"
#     from_port        = var.inbound_ports_alb_https
#     to_port          = var.inbound_ports_alb_https
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "altschoolAssignment-el-sg"
#   }
# }

