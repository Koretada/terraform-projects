
data "aws_ami" "image" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name" # Le nom du critère :) 
    values = ["ubuntu/images/hvm-ssd*/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_template" "this" {
  name_prefix   = "${var.name_prefix}-lt"
  image_id      = data.aws_ami.image.id
  instance_type = var.instance_type

  user_data              = base64encode(templatefile("${path.module}/scripts/userdata.sh.tftpl", {}))
  vpc_security_group_ids = var.security_group_ids_ec2
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  name_prefix         = "${var.name_prefix}-asg-"
  max_size            = var.max_size
  min_size            = var.min_size
  health_check_type   = length(var.target_group_arns) > 0 ? "ELB" : "EC2"
  desired_capacity    = var.desired_capacity
  force_delete        = true
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = var.target_group_arns
  health_check_grace_period = 300
    
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }
}