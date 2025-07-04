#!/bin/sh
set -e
JAR=$(ls target/*.jar | head -n 1)
echo "Ejecutando $JAR"
exec java -jar "$JAR" 