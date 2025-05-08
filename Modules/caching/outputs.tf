output "redis_cluster_id" {
  description = "ID del cluster Redis"
  value       = aws_elasticache_cluster.redis.cluster_id
}

output "endpoint" {
  description = "Endpoint de Redis"
  value       = aws_elasticache_cluster.redis.cache_nodes[0].address
}