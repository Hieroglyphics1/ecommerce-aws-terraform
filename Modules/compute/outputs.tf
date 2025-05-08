output "alb_dns_name" {
  description = "DNS del ALB"
  value       = aws_lb.app.dns_name
}

output "asg_name" {
  description = "Nombre del Auto Scaling Group"
  value       = aws_autoscaling_group.app.name
}

# output requerido para el módulo de monitoreo
output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = aws_lb.app.arn 
}