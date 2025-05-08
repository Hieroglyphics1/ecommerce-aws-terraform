resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.environment}-redis-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.environment}-redis-cluster"
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = 1  # Para producción, usa 2+ con réplicas
  parameter_group_name = "default.redis7"
  engine_version       = "7.1"
  port                 = 6379
  security_group_ids   = var.security_group_ids
  subnet_group_name    = aws_elasticache_subnet_group.redis.name

  tags = {
    Environment = var.environment
  }
}