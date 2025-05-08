output "sns_topic_arn" {
  description = "ARN del topic SNS para notificaciones"
  value       = aws_sns_topic.alerts.arn
}