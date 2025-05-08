#!/bin/bash
# Instala dependencias
yum update -y
yum install -y docker

# Configura variables de entorno
echo "export DB_HOST=${db_endpoint}" >> /etc/environment
echo "export REDIS_HOST=${cache_endpoint}" >> /etc/environment

# Inicia Docker y aplicación
systemctl start docker
docker run -d -p 8080:8080 -e DB_HOST=${db_endpoint} -e REDIS_HOST=${cache_endpoint} tu-imagen-app:latest