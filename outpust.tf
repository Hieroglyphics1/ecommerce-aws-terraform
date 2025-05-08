output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.compute.alb_dns_name
}

#output "cloudfront_domain" {
#description = "Domain name of the CloudFront distribution"
#value       = module.frontend.cloudfront_domain
#}

output "database_endpoint" {
  description = "Endpoint of the RDS database"
  value       = module.database.endpoint
  sensitive   = true
}

output "cache_endpoint" {
  description = "Endpoint of the ElastiCache cluster"
  value       = module.caching.endpoint
  sensitive   = true
}