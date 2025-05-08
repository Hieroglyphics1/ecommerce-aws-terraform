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
  description = "IDs de los security groups"
  type        = list(string)
}

variable "node_type" {
  description = "Tipo de instancia para Redis"
  type        = string
  default     = "cache.t3.small"  
}