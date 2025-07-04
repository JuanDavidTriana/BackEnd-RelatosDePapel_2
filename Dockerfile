# Usar Java 17
FROM openjdk:17-jdk-slim

# Establecer directorio de trabajo
WORKDIR /app

# Copiar el archivo JAR del microservicio principal (puedes cambiar por el que necesites)
COPY ms-books-catalogue/target/*.jar app.jar

# Exponer el puerto
EXPOSE 8081

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"] 