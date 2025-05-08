variable "environment" {
  description = "Entorno (dev/prod)"
  type        = string
}

variable "domain_name" {
  description = "Dominio principal (ej: midominio.com)"
  type        = string
  default     = ""  # Opcional: Si no tienes dominio, déjalo vacío
}

variable "bucket_name" {
  description = "Nombre único del bucket S3"
  type        = string
  default     = "static-assets-ecommerce"
}