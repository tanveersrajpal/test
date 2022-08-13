resource "aws_lb" "default" {
  name               = "clearpoint-lb-web"
  load_balancer_type = "application"
  subnets            = [aws_subnet.prod-subnet-public-1.id, aws_subnet.prod-subnet-public-2.id]
  security_groups    = [aws_security_group.public_security_group_ECS.id]
}

resource "aws_lb_target_group" "hello_world" {
  name        = "example-target-group"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc-main.id
  target_type = "instance"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    unhealthy_threshold = "2"
  }
}

resource "aws_lb_listener" "hello_world" {
  load_balancer_arn = aws_lb.default.id
  port              = 3000
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.hello_world.id
    type             = "forward"
  }
}