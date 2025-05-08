output "cluster_id" {
  description = "ID del cluster Aurora"
  value       = aws_rds_cluster.aurora_cluster.cluster_identifier
}

output "endpoint" {
  description = "Endpoint del writer"
  value       = aws_rds_cluster.aurora_cluster.endpoint
}