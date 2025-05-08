variable "environment" {
  description = "Entorno (dev/prod)"
  type        = string
}

variable "alb_arn" {
  description = "ARN del Application Load Balancer"
  type        = string
}

variable "redis_cluster_id" {
  description = "ID del cluster ElastiCache"
  type        = string
}

variable "db_cluster_id" {
  description = "ID del cluster Aurora"
  type        = string
}

variable "notification_email" {
  description = "Email para alertas"
  type        = string
}