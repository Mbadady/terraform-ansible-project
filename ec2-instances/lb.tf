resource "aws_alb" "alt-school-assignment" {
  # security_groups = ["${aws_security_group.elb_sg_http.id}", "${aws_security_group.elb_sg_https.id}"]
  security_groups = ["${aws_security_group.elb_sg.id}"]
  ip_address_type = "ipv4"
  load_balancer_type = "application"
  internal = false
  subnets = ["${aws_subnet.my_subnet_1.id}", "${aws_subnet.my_subnet_2.id}"]
  
}

resource "aws_alb_target_group" "my_alb" {
  name        = "my-alb"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_assignment_vpc.id
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alt-school-assignment.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.my_alb.arn
  }
}

resource "aws_alb_target_group_attachment" "aws_attachment" {
  count = length(aws_instance.ec2-instance)
  target_group_arn = aws_alb_target_group.my_alb.arn
  target_id        = aws_instance.ec2-instance[count.index].id
}

