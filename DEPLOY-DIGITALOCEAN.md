# 🚀 Despliegue en DigitalOcean

## 📋 Requisitos Previos

- Cuenta en DigitalOcean
- Acceso SSH a tu Droplet
- Dominio (opcional pero recomendado)

## 🎯 Opciones de Despliegue

### Opción 1: DigitalOcean App Platform (Recomendado)

1. **Ve a [DigitalOcean App Platform](https://cloud.digitalocean.com/apps)**
2. **Crea una nueva app** desde tu repositorio de GitHub
3. **Configura cada servicio** como un componente separado

### Opción 2: DigitalOcean Droplet con Docker (Más control)

## 🖥️ Configuración del Droplet

### Paso 1: Crear Droplet

1. **Ve a [DigitalOcean Droplets](https://cloud.digitalocean.com/droplets)**
2. **Crea un nuevo Droplet:**
   - **Ubuntu 22.04 LTS**
   - **Plan:** Basic (2GB RAM, 1 vCPU mínimo)
   - **Ubicación:** Cerca de tus usuarios
   - **Autenticación:** SSH Key (recomendado)

### Paso 2: Conectar al Droplet

```bash
ssh root@TU_IP_DEL_DROPLET
```

### Paso 3: Instalar Dependencias

```bash
# Actualizar sistema
apt update && apt upgrade -y

# Instalar Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Instalar Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Agregar usuario al grupo docker
usermod -aG docker $USER
```

## 🚀 Despliegue Automático

### Paso 1: Clonar Repositorio

```bash
git clone https://github.com/JuanDavidTriana/BackEnd-RelatosDePapel_2.git
cd BackEnd-RelatosDePapel_2
```

### Paso 2: Ejecutar Script de Despliegue

```bash
chmod +x deploy-digitalocean.sh
./deploy-digitalocean.sh
```

### Paso 3: Verificar Despliegue

```bash
# Ver estado de servicios
docker-compose ps

# Ver logs
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs -f api-gateway
```

## 🌐 URLs de Acceso

Una vez desplegado, podrás acceder a:

- **API Gateway:** `http://TU_IP/api/`
- **Eureka Server:** `http://TU_IP/eureka/`
- **Books Catalogue:** `http://TU_IP/catalogue/`
- **Books Payments:** `http://TU_IP/payments/`
- **Health Check:** `http://TU_IP/health`

## 🔧 Comandos Útiles

```bash
# Iniciar servicios
docker-compose up -d

# Detener servicios
docker-compose down

# Reiniciar un servicio específico
docker-compose restart api-gateway

# Ver logs en tiempo real
docker-compose logs -f

# Actualizar código y redeploy
git pull
docker-compose down
docker-compose build
docker-compose up -d
```

## 🔒 Configuración de Seguridad

### Firewall

```bash
# Instalar UFW
apt install ufw

# Configurar reglas
ufw allow ssh
ufw allow 80
ufw allow 443
ufw enable
```

### SSL/HTTPS (Opcional)

```bash
# Instalar Certbot
apt install certbot python3-certbot-nginx

# Obtener certificado SSL
certbot --nginx -d tu-dominio.com
```

## 📊 Monitoreo

### Verificar Estado de Servicios

```bash
# Estado general
docker-compose ps

# Uso de recursos
docker stats

# Logs de errores
docker-compose logs --tail=100 | grep ERROR
```

### Health Checks

```bash
# Verificar API Gateway
curl http://localhost/health

# Verificar Eureka
curl http://localhost/eureka/

# Verificar servicios individuales
curl http://localhost:8081/actuator/health
curl http://localhost:8082/actuator/health
```

## 🛠️ Solución de Problemas

### Servicio no inicia

```bash
# Ver logs específicos
docker-compose logs [nombre-servicio]

# Reiniciar servicio
docker-compose restart [nombre-servicio]

# Reconstruir imagen
docker-compose build [nombre-servicio]
```

### Problemas de conectividad

```bash
# Verificar puertos
netstat -tulpn | grep :8080

# Verificar red Docker
docker network ls
docker network inspect backend-network
```

### Problemas de memoria

```bash
# Ver uso de memoria
free -h
docker system df

# Limpiar recursos no utilizados
docker system prune -a
```

## 📈 Escalabilidad

Para escalar horizontalmente:

```bash
# Escalar un servicio específico
docker-compose up -d --scale ms-books-catalogue=3

# Verificar réplicas
docker-compose ps
```

## 💰 Optimización de Costos

- **Droplet básico:** $6/mes (2GB RAM)
- **Droplet estándar:** $12/mes (4GB RAM) - Recomendado para producción
- **Backup automático:** $2/mes adicional

## 📞 Soporte

Si tienes problemas:

1. **Verifica logs:** `docker-compose logs -f`
2. **Revisa estado:** `docker-compose ps`
3. **Reinicia servicios:** `docker-compose restart`
4. **Consulta documentación:** [DigitalOcean Docs](https://docs.digitalocean.com/)

---

**¡Tu backend está listo para producción en DigitalOcean! 🎉** 