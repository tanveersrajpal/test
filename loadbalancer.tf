resource "aws_lb" "default" {
  name               = "clearpoint-lb-web"
  load_balancer_type = "application"
  subnets            = [aws_subnet.prod-subnet-public-1.id, aws_subnet.prod-subnet-public-2.id]
  security_groups    = [aws_security_group.public-security-group-LB.id]
}

resource "aws_lb_target_group" "tg-clearpoint-lb-web-frontend" {
  name        = "tg-clearpoint-lb-web-frontend"
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
  stickiness {
    enabled  = true
    type     = "lb_cookie"
    duration = 600
  }
}
resource "aws_lb_target_group" "tg-clearpoint-lb-web-backend" {
  name        = "tg-clearpoint-lb-web-backend"
  port        = 3002
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
    path                = "/api/todoItems"
  }
  stickiness {
    enabled  = true
    type     = "lb_cookie"
    duration = 600
  }
}
resource "aws_lb_listener" "listner-clearpoint-lb-web-frontend" {
  load_balancer_arn = aws_lb.default.id
  port              = 3000
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg-clearpoint-lb-web-frontend.id
    type             = "forward"
  }
}
resource "aws_lb_listener" "listner-clearpoint-lb-web-backend" {
  load_balancer_arn = aws_lb.default.id
  port              = 3002
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg-clearpoint-lb-web-backend.arn
    type             = "forward"
  }
}
