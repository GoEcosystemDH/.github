## Descripcion

<!-- Describe brevemente que cambia este PR y por que -->

## Task Azure DevOps

<!-- Link al work item: https://dev.azure.com/goecosystem/Go-Devops/_workitems/edit/XXXX -->

- Task: #

## Tipo de Cambio

- [ ] Nueva funcionalidad (feat)
- [ ] Correccion de bug (fix)
- [ ] Refactorizacion (refactor)
- [ ] Documentacion (docs)
- [ ] CI/CD (ci)
- [ ] Mantenimiento (chore)

## Impacto en Modulos

<!-- Marca los modulos clinicos afectados por este cambio -->

### Modulos afectados

- [ ] Citas / Agenda
- [ ] Evolucion Clinica
- [ ] Ordenes Medicas
- [ ] Historia Clinica
- [ ] Farmacia / Medicamentos
- [ ] Facturacion
- [ ] Laboratorio / Resultados
- [ ] Admisiones / Registro
- [ ] Reportes / Estadisticas
- [ ] Autenticacion / Permisos
- [ ] Otro: <!-- especifica -->

### Nivel de impacto

- [ ] **Alto** - Cambia flujo principal del modulo o afecta datos criticos del paciente
- [ ] **Medio** - Modifica funcionalidad existente sin afectar flujo principal
- [ ] **Bajo** - Cambio cosmético, refactor interno o mejora menor

### Modulos dependientes

<!-- Lista modulos que podrian verse afectados indirectamente -->

-

## Checklist

### Codigo

- [ ] El codigo sigue los estandares del proyecto
- [ ] No hay secrets, tokens o credenciales en el codigo
- [ ] Se manejan los errores correctamente
- [ ] No hay console.log / fmt.Println de debug

### Testing

- [ ] Se agregaron o actualizaron tests (si aplica)
- [ ] Los tests existentes siguen pasando
- [ ] Se probo manualmente en ambiente local
- [ ] Se verifico que no hay regresiones en modulos dependientes

### Datos clinicos

- [ ] Los cambios NO alteran datos existentes de pacientes
- [ ] Las migraciones de BD son reversibles (si aplica)
- [ ] Se valida entrada de datos clinicos correctamente
- [ ] Los campos obligatorios estan protegidos

### Despliegue

- [ ] No hay breaking changes
- [ ] Las variables de entorno necesarias estan documentadas
- [ ] El Dockerfile se actualizo (si aplica)
- [ ] El docker-compose se actualizo (si aplica)

### Documentacion

- [ ] El README se actualizo (si aplica)
- [ ] Se documentaron cambios en la Wiki (si aplica)

## Capturas de Pantalla (si aplica)

<!-- Agrega capturas o GIFs que muestren el cambio -->

## Notas para el Reviewer

<!-- Algo especifico que el reviewer deba tener en cuenta -->
