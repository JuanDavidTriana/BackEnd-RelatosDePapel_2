#!/bin/bash

echo "🚀 Desplegando Backend en DigitalOcean..."

# Verificar que Docker esté instalado
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado. Instalando..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    sudo usermod -aG docker $USER
    echo "✅ Docker instalado. Reinicia la sesión y ejecuta el script nuevamente."
    exit 1
fi

# Verificar que Docker Compose esté instalado
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose no está instalado. Instalando..."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "✅ Docker Compose instalado."
fi

# Construir y ejecutar los servicios
echo "🔨 Construyendo servicios..."
docker-compose build

echo "🚀 Iniciando servicios..."
docker-compose up -d

echo "⏳ Esperando que los servicios estén listos..."
sleep 30

# Verificar el estado de los servicios
echo "📊 Estado de los servicios:"
docker-compose ps

echo "✅ Despliegue completado!"
echo ""
echo "🌐 URLs de los servicios:"
echo "Eureka Server: http://localhost:8761"
echo "Books Catalogue: http://localhost:8081"
echo "Books Payments: http://localhost:8082"
echo "API Gateway: http://localhost:8080"
echo ""
echo "📝 Para ver logs: docker-compose logs -f [servicio]"
echo "🛑 Para detener: docker-compose down" 