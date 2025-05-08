# Application Load Balancer (ALB)
resource "aws_lb" "app" {
  name               = "${var.environment}-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  tags = {
    Environment = var.environment
  }
}

# Target Group para el ALB
resource "aws_lb_target_group" "app" {
  name     = "${var.environment}-app-tg"
  port     = 8080  # Puerto de tu aplicación
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/health"  # Ruta de health check
  }
}

resource "aws_launch_template" "app" {
  # ... (configuración existente)
  instance_type = var.instance_type       # Usará t3.micro del tfvars
  image_id      = var.ami_id              
  key_name      = var.key_name            

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    db_endpoint    = var.db_endpoint
    cache_endpoint = var.cache_endpoint
  }))

  network_interfaces {
    security_groups = var.security_group_ids
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Environment = var.environment
    }
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "app" {
  desired_capacity    = 2
  max_size            = 5
  min_size            = 2
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = [aws_lb_target_group.app.arn]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}