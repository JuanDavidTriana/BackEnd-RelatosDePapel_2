# Usar Java 17
FROM eclipse-temurin:17-jdk

# Establecer directorio de trabajo
WORKDIR /app

# Copiar el archivo pom.xml primero para aprovechar la caché de Docker
COPY pom.xml .

# Copiar el código fuente
COPY src ./src

# Construir la aplicación
RUN mvn clean package -DskipTests

# Exponer el puerto del servicio de pagos
EXPOSE 8082

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "target/*.jar"] 