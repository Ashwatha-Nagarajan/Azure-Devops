resource "aws_lb" "an_lb" {
  name               = "an-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.an_sg.id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "an_lb"
  }
}

resource "aws_lb_listener" "an_listener" {
  load_balancer_arn = aws_lb.an_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}

