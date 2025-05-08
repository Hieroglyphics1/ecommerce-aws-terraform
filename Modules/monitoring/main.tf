# Topic SNS para notificaciones
resource "aws_sns_topic" "alerts" {
  name = "${var.environment}-alerts-topic"
}

# Suscripción por email
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

# Alarmas para el ALB
resource "aws_cloudwatch_metric_alarm" "alb_5xx_errors" {
  alarm_name          = "${var.environment}-alb-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  threshold           = 5
  statistic           = "Sum"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  dimensions = {
    LoadBalancer = var.alb_arn
  }
}

# Alarmas para Aurora PostgreSQL
resource "aws_cloudwatch_metric_alarm" "rds_cpu" {
  alarm_name          = "${var.environment}-rds-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300  # 5 minutos en segundos
  threshold           = 80
  statistic           = "Average"  # ← ¡Nuevo campo requerido!
  alarm_actions       = [aws_sns_topic.alerts.arn]
  dimensions = {
    DBClusterIdentifier = var.db_cluster_id
  }
}

# Alarmas para Redis
resource "aws_cloudwatch_metric_alarm" "redis_memory" {
  alarm_name          = "${var.environment}-redis-high-memory"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "DatabaseMemoryUsagePercentage"
  namespace           = "AWS/ElastiCache"
  period              = 300
  threshold           = 75
  statistic           = "Average"  # ← ¡Nuevo campo requerido!
  alarm_actions       = [aws_sns_topic.alerts.arn]
  dimensions = {
    CacheClusterId = var.redis_cluster_id
  }
}