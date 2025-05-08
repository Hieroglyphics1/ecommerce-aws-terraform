# 🛒 Infraestructura Ecommerce en AWS con Terraform

![Terraform AWS Ecommerce](https://img.shields.io/badge/terraform-1.3%2B-blue)
![AWS](https://img.shields.io/badge/AWS-EC2%2C%20RDS%2C%20ElastiCache-orange)

Este repositorio contiene la infraestructura como código para desplegar una plataforma ecommerce completa en AWS usando Terraform.

##  Arquitectura

# Diagrama de Arquitectura

https://www.mermaidchart.com/app/projects/2ac29c38-3f8d-4956-9fa0-5d1e795ef661/diagrams/4c40fc28-56b9-444c-9580-70e406c8bd20/version/v0.1/edit

Componentes principales:
- **Frontend**: CloudFront + S3
- **Backend**: ALB + EC2 Auto Scaling
- **Base de datos**: Amazon RDS (PostgreSQL/MySQL)
- **Caché**: ElastiCache Redis
- **Redes**: VPC con subnets públicas/privadas


## Estructura del Proyecto:
.
├── modules/
│   ├── networking/       # VPC, Subnets, Security Groups
│   ├── database/         # RDS Configuration
│   ├── compute/          # EC2, ALB, Auto Scaling
│   ├── caching/          # ElastiCache Redis
│   └── monitoring/       # CloudWatch Alarms
├── main.tf               # Configuración principal
├── variables.tf          # Variables de entrada
├── outputs.tf            # Valores de salida
├── terraform.tfvars.example  # Ejemplo de configuración
└── README.md             # Este archivo



## Requisitos Previos
1. **Terraform** (>= 1.3.0) - [Instalación](https://learn.hashicorp.com/tutorials/terraform/install-cli)
2. **AWS CLI** configurado - [Guía](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)
3. **Credenciales AWS** con permisos adecuados
4. **Par de claves SSH** registrado en AWS

##  Configuración Inicial

1. Copiar el archivo de configuración de ejemplo:
   ```bash
   cp terraform.tfvars.example terraform.tfvars

# Credenciales críticas (usar Secrets Manager en producción)
db_username = "admin_db"
db_password = "password_segura" # Cambiar obligatoriamente

# Inicializar Terraform
terraform init

# Revisar cambios planeados
terraform plan -var-file="terraform.tfvars"

# Aplicar cambios
terraform apply -var-file="terraform.tfvars"

# Destruir infraestructura (cuidado!)
terraform destroy
   
