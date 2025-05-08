resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "${var.environment}-aurora-cluster"
  engine                  = "aurora-postgresql"
  engine_version          = "15.3"
  database_name           = var.db_name
  master_username         = var.db_username
  master_password         = var.db_password
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = var.environment == "dev" ? true : false
  vpc_security_group_ids  = var.security_group_ids
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnets.name

  serverlessv2_scaling_configuration {
    min_capacity = 0.5
    max_capacity = 4
  }
}

resource "aws_rds_cluster_instance" "aurora_instances" {
  count              = var.environment == "prod" ? 2 : 1
  identifier         = "${var.environment}-aurora-instance-${count.index + 1}" # Nombre único
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.serverless"  
  engine             = aws_rds_cluster.aurora_cluster.engine
  engine_version     = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = false          # Seguridad básica
}

resource "aws_db_subnet_group" "aurora_subnets" {
  name       = "${var.environment}-aurora-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Environment = var.environment
  }
}