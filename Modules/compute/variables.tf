variable "environment" {
  description = "Entorno (dev/prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "subnet_ids" {
  description = "IDs de las subnets privadas"
  type        = list(string)
}

variable "security_group_ids" {
  description = "IDs de los Security Groups"
  type        = list(string)
}

variable "instance_type" {
  description = "Tipo de instancia EC2 (ej: t3.medium)"
  type        = string
  default     = "t3.medium"
}

variable "ami_id" {
  description = "AMI base para las instancias"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 en us-east-1
}

variable "key_name" {
  description = "Nombre del key pair SSH para acceder a las instancias EC2"
  type        = string
}

variable "db_endpoint" {
  description = "Endpoint de la base de datos Aurora"
  type        = string
}

variable "cache_endpoint" {
  description = "Endpoint de ElastiCache Redis"
  type        = string
}