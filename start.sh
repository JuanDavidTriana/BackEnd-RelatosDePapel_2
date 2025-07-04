#!/bin/bash

echo "🚀 Iniciando Relatos de Papel Backend..."

# Verificar que Docker esté instalado
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado. Por favor instala Docker primero."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose no está instalado. Por favor instala Docker Compose primero."
    exit 1
fi

# Construir e iniciar todos los servicios
echo "📦 Construyendo e iniciando servicios..."
docker-compose up --build -d

echo "⏳ Esperando que los servicios estén listos..."
sleep 30

echo "✅ Servicios iniciados!"
echo ""
echo "🌐 URLs de acceso:"
echo "   Eureka Server: http://localhost:8761"
echo "   API Gateway:   http://localhost:8080"
echo "   Catálogo:      http://localhost:8081"
echo "   Pagos:         http://localhost:8082"
echo ""
echo "📋 Comandos útiles:"
echo "   Ver logs:      docker-compose logs -f"
echo "   Parar:         docker-compose down"
echo "   Reiniciar:     docker-compose restart" 