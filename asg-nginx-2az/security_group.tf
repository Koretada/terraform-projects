resource "aws_security_group" "elb_allow_http" {
  name        = "elb_allow_http"
  vpc_id      = aws_vpc.main.id
  description = "Allow HTTP traffic from internet"
}

resource "aws_security_group_rule" "elb_allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  security_group_id = aws_security_group.elb_allow_http.id
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  vpc_id      = aws_vpc.main.id
  description = "Allow HTTP traffic from ELB"
}

resource "aws_security_group_rule" "allow_http_ipv4" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.allow_http.id
  source_security_group_id = aws_security_group.elb_allow_http.id 
}

locals {
  security_group = {
    elb = aws_security_group.elb_allow_http.id
    ec2 = aws_security_group.allow_http.id
  }
}

resource "aws_security_group_rule" "allow_all_egress" {
  for_each = local.security_group
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = each.value
  cidr_blocks = [ "0.0.0.0/0" ]
}