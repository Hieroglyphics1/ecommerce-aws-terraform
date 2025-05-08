variable "environment" {
  description = "Entorno (dev/prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  type        = list(string)
}

variable "security_group_ids" {
  description = "IDs de los security groups"
  type        = list(string)
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "ecommercedb"
}

variable "db_username" {
  description = "Usuario maestro"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Contraseña maestra"
  type        = string
  sensitive   = true
}