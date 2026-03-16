# Política de Seguridad

## Versiones Soportadas

| Proyecto | Versión | Soportada |
|----------|---------|-----------|
| HIS (Servicios, Ospedale, Cirugía) | Última | Sí |
| RCF (API, App, Android) | Última | Sí |
| Costos / CMI | Última | Sí |
| Repos archivados | - | No |

## Reportar una Vulnerabilidad

Si descubres una vulnerabilidad de seguridad en alguno de nuestros repositorios:

1. **NO** crees un Issue público.
2. Envía un reporte directamente al equipo de DevOps.
3. Incluye:
   - Descripción de la vulnerabilidad
   - Pasos para reproducirla
   - Impacto potencial
   - Sugerencia de solución (si la tienes)

## Tiempo de Respuesta

| Severidad | Tiempo de Respuesta | Tiempo de Resolución |
|-----------|--------------------|-----------------------|
| Crítica | 24 horas | 72 horas |
| Alta | 48 horas | 1 semana |
| Media | 1 semana | 2 semanas |
| Baja | 2 semanas | Próximo release |

## Prácticas de Seguridad

Todos los colaboradores deben seguir estas prácticas:

- **Secrets:** Nunca incluir tokens, contraseñas o API keys en el código fuente. Usar GitHub Secrets.
- **Dependencias:** Mantener dependencias actualizadas. Dependabot está configurado para alertas automáticas.
- **Docker:** No incluir credenciales en imágenes. Usar multi-stage builds.
- **Inputs:** Validar toda entrada de usuario. Usar consultas parametrizadas para SQL.
- **HTTPS:** Toda comunicación con APIs externas debe ser sobre HTTPS.
- **Acceso:** Principio de menor privilegio. Solicitar solo los permisos necesarios.

## Herramientas de Seguridad Activas

- **Dependabot:** Alertas de vulnerabilidades en dependencias
- **Secret Scanning:** Detección de secrets expuestos en commits
- **Branch Protection:** PRs requeridos con revisión antes de merge a main
