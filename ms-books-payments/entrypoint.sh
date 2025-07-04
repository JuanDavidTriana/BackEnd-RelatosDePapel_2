#!/bin/sh
set -e

# Función para esperar a que Eureka esté disponible
wait_for_eureka() {
    echo "Esperando a que Eureka Server esté disponible..."
    while ! curl -f http://eureka-server:8761/actuator/health > /dev/null 2>&1; do
        echo "Eureka Server no está disponible aún, esperando..."
        sleep 5
    done
    echo "Eureka Server está disponible!"
}

# Esperar a que Eureka esté disponible
wait_for_eureka

JAR=$(ls target/*.jar | head -n 1)
echo "Ejecutando $JAR"
exec java -jar "$JAR" 