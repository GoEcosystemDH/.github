# Guía de Contribución

Gracias por tu interés en contribuir a los proyectos de **Go Ecosystem DH**. Esta guía describe el proceso y las convenciones que seguimos.

> **Documentación completa:** Consulta el espacio de [Onboarding Desarrollo](https://wiki.goecosystemdh.com/s/onboarding) en nuestra Wiki para guías detalladas, estándares de código, configuración del entorno y preguntas frecuentes.

## 📋 Antes de Empezar

1. Configura tu entorno siguiendo la guía de [Configuración del Entorno](https://wiki.goecosystemdh.com/s/onboarding) en la Wiki.
2. Verifica que existe una **Task o User Story** asignada en [Azure DevOps](https://dev.azure.com/goecosystem/Go-Devops/_workitems/) para el trabajo que vas a realizar.
3. Si no existe, comunícalo al equipo para que se cree el work item correspondiente.

## 🔀 Flujo de Branches

Seguimos el siguiente esquema de branches:

| Branch | Propósito |
|--------|-----------|
| `main` | Producción — siempre estable y desplegable |
| `develop` | Integración — branch base para desarrollo |
| `feature/*` | Nuevas funcionalidades (ej: `feature/agregar-modulo-citas`) |
| `hotfix/*` | Correcciones urgentes en producción |
| `release/*` | Preparación de releases |

Más detalle en la página [Flujo de Trabajo](https://wiki.goecosystemdh.com/s/onboarding) de la Wiki.

## 🚀 Proceso de Contribución

### 1. Crear Branch

```bash
git checkout develop
git pull origin develop
git checkout -b feature/nombre-descriptivo
```

### 2. Desarrollar

- Escribe código limpio y legible.
- Sigue los [Estándares de Código](https://wiki.goecosystemdh.com/s/onboarding) documentados en la Wiki.
- Incluye tests cuando aplique.
- No subas secrets, credenciales ni archivos `.env`.

### 3. Commits

Usamos **Conventional Commits**:

```
<tipo>: <descripción corta>

<cuerpo opcional>
```

**Tipos válidos:**
- `feat`: Nueva funcionalidad
- `fix`: Corrección de bug
- `refactor`: Refactorización sin cambio funcional
- `docs`: Cambios en documentación
- `test`: Agregar o modificar tests
- `chore`: Tareas de mantenimiento
- `perf`: Mejora de rendimiento
- `ci`: Cambios en CI/CD

### 4. Pull Request

- Crea un PR hacia `develop` (o `main` para hotfixes).
- Llena la plantilla de PR completamente.
- Asigna reviewers del equipo correspondiente.
- Vincula la Task de Azure DevOps en la descripción.
- Espera al menos **1 aprobación** antes de hacer merge.

### 5. Code Review

Al revisar PRs de otros:
- Verifica que el código cumple los estándares.
- Prueba localmente si es un cambio significativo.
- Deja comentarios constructivos y específicos.
- Aprueba solo si estás seguro de la calidad.

## 📏 Estándares de Código

Consulta la guía completa de [Estándares de Código](https://wiki.goecosystemdh.com/s/onboarding) en la Wiki. Resumen:

- **Go:** Seguir `gofmt` y `go vet`. Manejar errores explícitamente.
- **Angular/React:** Seguir la guía de estilos del framework. Componentes pequeños y reutilizables.
- **Docker:** Imágenes multi-stage. No incluir credenciales en Dockerfiles.
- **General:** Funciones cortas (<50 líneas). Archivos enfocados (<800 líneas). Sin valores hardcodeados.

## 🔒 Seguridad

- **Nunca** subas secrets, tokens o contraseñas al repositorio.
- Usa GitHub Secrets para variables sensibles.
- Reporta vulnerabilidades según nuestra [Política de Seguridad](SECURITY.md).

## 📚 Recursos

| Recurso | Enlace |
|---------|--------|
| Wiki - Onboarding completo | [wiki.goecosystemdh.com/s/onboarding](https://wiki.goecosystemdh.com/s/onboarding) |
| Wiki - Flujo de Trabajo | [wiki.goecosystemdh.com/s/onboarding](https://wiki.goecosystemdh.com/s/onboarding) |
| Wiki - Estándares de Código | [wiki.goecosystemdh.com/s/onboarding](https://wiki.goecosystemdh.com/s/onboarding) |
| Wiki - Preguntas Frecuentes | [wiki.goecosystemdh.com/s/onboarding](https://wiki.goecosystemdh.com/s/onboarding) |
| Azure DevOps - Backlog | [dev.azure.com/goecosystem/Go-Devops](https://dev.azure.com/goecosystem/Go-Devops/_workitems/) |
| Política de Seguridad | [SECURITY.md](SECURITY.md) |
| Código de Conducta | [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) |

## ❓ Preguntas

Si tienes dudas sobre el proceso, consulta las [Preguntas Frecuentes](https://wiki.goecosystemdh.com/s/onboarding) en la Wiki o habla con el equipo de DevOps.
