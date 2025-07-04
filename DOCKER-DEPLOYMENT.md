# 🐳 Despliegue con Docker Compose

## 📋 Requisitos Previos

- Docker Desktop instalado
- Docker Compose instalado
- Mínimo 4GB RAM disponible

## 🚀 Inicio Rápido

### Opción 1: Script Automático
```bash
# Dar permisos de ejecución
chmod +x start.sh

# Ejecutar
./start.sh
```

### Opción 2: Comandos Manuales
```bash
# Construir e iniciar todos los servicios
docker-compose up --build -d

# Ver logs en tiempo real
docker-compose logs -f

# Parar todos los servicios
docker-compose down
```

## 🌐 URLs de Acceso

| Servicio | URL | Descripción |
|----------|-----|-------------|
| **Eureka Server** | http://localhost:8761 | Panel de control de microservicios |
| **API Gateway** | http://localhost:8080 | Punto de entrada principal |
| **Catálogo** | http://localhost:8081 | Servicio de libros |
| **Pagos** | http://localhost:8082 | Servicio de compras |

## 📡 Endpoints de Prueba

### Catálogo de Libros
```bash
# Listar libros
curl http://localhost:8080/api/books

# Crear libro
curl -X POST http://localhost:8080/api/books \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Cien años de soledad",
    "author": "Gabriel García Márquez",
    "price": 25.99,
    "isbn": "9788497593797"
  }'
```

### Pagos
```bash
# Crear compra
curl -X POST http://localhost:8080/api/payments/purchases \
  -H "Content-Type: application/json" \
  -d '{
    "bookId": 1,
    "quantity": 1,
    "customerEmail": "cliente@ejemplo.com"
  }'
```

## 🔧 Comandos Útiles

```bash
# Ver estado de los servicios
docker-compose ps

# Ver logs de un servicio específico
docker-compose logs eureka-server
docker-compose logs api-gateway
docker-compose logs books-catalogue
docker-compose logs books-payments

# Reiniciar un servicio
docker-compose restart api-gateway

# Reconstruir un servicio
docker-compose up --build api-gateway

# Acceder al contenedor MySQL
docker-compose exec mysql mysql -u relatos -p books_catalogue

# Ver uso de recursos
docker stats
```

## 🛠️ Solución de Problemas

### Servicios no inician
```bash
# Verificar logs
docker-compose logs

# Reconstruir todo
docker-compose down
docker-compose up --build
```

### Base de datos no conecta
```bash
# Verificar MySQL
docker-compose logs mysql

# Reiniciar MySQL
docker-compose restart mysql
```

### Eureka no registra servicios
```bash
# Verificar configuración
docker-compose logs eureka-server

# Reiniciar Eureka
docker-compose restart eureka-server
```

## 📊 Monitoreo

### Eureka Dashboard
- URL: http://localhost:8761
- Muestra todos los servicios registrados
- Estado de salud de cada servicio

### Logs Centralizados
```bash
# Ver todos los logs
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs -f api-gateway
```

## 🔒 Seguridad

### Variables de Entorno
- Las credenciales están en el `docker-compose.yml`
- Para producción, usar variables de entorno
- Cambiar contraseñas por defecto

### Redes
- Todos los servicios están en la red `relatos-network`
- Aislamiento de red automático
- Comunicación interna segura

## 📈 Escalabilidad

### Escalar un servicio
```bash
# Escalar API Gateway a 3 instancias
docker-compose up --scale api-gateway=3
```

### Balanceo de Carga
- Eureka maneja el balanceo automáticamente
- Spring Cloud LoadBalancer activo
- Distribución automática de carga

## 🗑️ Limpieza

```bash
# Parar y eliminar contenedores
docker-compose down

# Eliminar también volúmenes (datos)
docker-compose down -v

# Eliminar imágenes
docker-compose down --rmi all
```

## 📝 Notas Importantes

1. **Primera ejecución**: Puede tardar varios minutos en descargar imágenes
2. **Base de datos**: Los datos se mantienen en volumen `mysql_data`
3. **Puertos**: Asegúrate de que los puertos 8080, 8081, 8082, 8761, 3306 estén libres
4. **Memoria**: Cada servicio requiere ~512MB RAM mínimo
5. **Red**: Los servicios se comunican por nombres de contenedor

## 🆘 Soporte

Si tienes problemas:
1. Revisa los logs: `docker-compose logs`
2. Verifica que Docker esté corriendo
3. Asegúrate de tener suficiente memoria disponible
4. Reinicia Docker Desktop si es necesario 