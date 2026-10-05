module "compute" {
  source = "./module/compute"
  subnet_ids = [ for s in aws_subnet.main_private : s.id ]
  security_group_ids_ec2 = [ aws_security_group.allow_http.id ]
  target_group_arns = [ aws_lb_target_group.nginx.arn]
  name_prefix = "app-nginx"
  instance_type = "t3.micro"
  min_size = 2
  max_size = 4
  desired_capacity = 2
}

resource "aws_lb" "alb" {
    name = "alb-http"
    load_balancer_type = "application"
    security_groups = [aws_security_group.elb_allow_http.id]
    subnets = [for subnet in aws_subnet.main_public : subnet.id]
}

resource "aws_lb_target_group" "nginx" {
  name = "lb-tg-nginx"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
  target_type = "instance"
  deregistration_delay = 30
  
  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    port = 80
    interval = 15
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }
}