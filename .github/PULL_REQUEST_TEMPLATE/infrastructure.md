## Descripcion

<!-- Describe brevemente que cambia este PR y por que -->

## Task Azure DevOps

<!-- Link al work item: https://dev.azure.com/goecosystem/Go-Devops/_workitems/edit/XXXX -->

- Task: #

## Tipo de Cambio

- [ ] Cambio en CI/CD pipeline
- [ ] Cambio en Dockerfile / docker-compose
- [ ] Cambio en configuracion de infraestructura
- [ ] Cambio en monitoreo / alertas
- [ ] Cambio en secrets / variables de entorno
- [ ] Cambio en red / networking
- [ ] Otro: <!-- especifica -->

## Servicios Afectados

<!-- Marca los servicios que se ven impactados -->

- [ ] GitHub Actions (workflows)
- [ ] Self-hosted runners
- [ ] Docker registry
- [ ] Grafana / Monitoreo
- [ ] Base de datos
- [ ] Servidor de aplicacion
- [ ] DNS / Proxy reverso
- [ ] Otro: <!-- especifica -->

## Evaluacion de Riesgo

### Disponibilidad

- [ ] **Sin downtime** - El cambio no requiere reinicio de servicios
- [ ] **Downtime planificado** - Requiere ventana de mantenimiento
- [ ] **Rolling update** - Se puede aplicar sin interrumpir el servicio

### Rollback

- [ ] El cambio es facilmente reversible
- [ ] Se documento el proceso de rollback
- [ ] Se requiere coordinacion con el equipo para revertir

## Checklist

### Seguridad

- [ ] No se exponen puertos innecesarios
- [ ] No hay secrets hardcodeados (usar GitHub Secrets)
- [ ] Las imagenes Docker usan tags especificos (no :latest en produccion)
- [ ] Se revisaron los permisos de acceso

### Configuracion

- [ ] Las variables de entorno estan documentadas
- [ ] Los archivos de configuracion tienen valores por defecto seguros
- [ ] Se actualizaron los ambientes afectados (dev, staging, prod)

### Testing

- [ ] Se probo en ambiente local / dev
- [ ] El pipeline CI pasa correctamente
- [ ] Se verifico el health check del servicio

### Documentacion

- [ ] Se actualizo la documentacion de infraestructura
- [ ] Se documentaron cambios en la Wiki (si aplica)
- [ ] Se notifico al equipo sobre el cambio

## Plan de Despliegue

<!-- Describe paso a paso como se aplicara este cambio -->

1.
2.
3.

## Notas para el Reviewer

<!-- Algo especifico que el reviewer deba tener en cuenta -->
