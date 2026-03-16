<!-- 
  README TEMPLATE - GoEcosystemDH
  
  Instrucciones:
  1. Copia este template al README.md de tu repositorio
  2. Reemplaza todo lo que esté entre {{ }} con la información real
  3. Elimina las secciones que no apliquen a tu proyecto
  4. Elimina este bloque de comentario cuando termines
  
  Guía completa: https://wiki.goecosystemdh.com/s/onboarding
-->

# {{ nombre-del-repo }}

{{ Descripción breve del proyecto en 1-2 oraciones. Qué hace, para quién y por qué existe. }}

<!-- Descomenta los badges que apliquen a tu repo -->
<!-- ![CI](https://github.com/GoEcosystemDH/{{ nombre-del-repo }}/actions/workflows/ci.yml/badge.svg) -->
<!-- ![CD](https://github.com/GoEcosystemDH/{{ nombre-del-repo }}/actions/workflows/cd.yml/badge.svg) -->

## Tabla de Contenido

- [Descripción](#descripción)
- [Requisitos](#requisitos)
- [Instalación](#instalación)
- [Uso](#uso)
- [Despliegue](#despliegue)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Contribución](#contribución)
- [Contacto](#contacto)

## Descripción

{{ Descripción detallada del proyecto:
- Qué problema resuelve
- Principales funcionalidades
- A qué producto pertenece (HIS, RCF, CMI, Cero Trámites, etc.)
- Relación con otros repos si aplica
}}

## Requisitos

| Herramienta | Versión |
|-------------|---------|
| {{ Docker }} | {{ 4.x+ }} |
| {{ Go / Node.js / .NET }} | {{ versión }} |
| {{ Base de datos }} | {{ versión }} |

## Instalación

### Clonar el repositorio

```bash
gh repo clone GoEcosystemDH/{{ nombre-del-repo }}
cd {{ nombre-del-repo }}
```

### Variables de entorno

Copiar el archivo de ejemplo y configurar:

```bash
cp .env.example .env
# Editar .env con los valores correspondientes
```

### Con Docker (recomendado)

```bash
docker compose up -d
```

### Sin Docker

```bash
{{ comandos de instalación sin Docker }}
```

## Uso

{{ Cómo usar la aplicación una vez instalada:
- URL local (ej: http://localhost:3000)
- Endpoints principales (si es API)
- Funcionalidades clave
}}

## Despliegue

### Ambientes

| Ambiente | URL | Branch | Método |
|----------|-----|--------|--------|
| Producción | {{ url-produccion }} | `main` | GitHub Actions → Docker |
| Staging | {{ url-staging }} | `develop` | GitHub Actions → Docker |

### CI/CD

El despliegue se ejecuta automáticamente via GitHub Actions:

- **Push a `main`** → Build → Push Docker Hub → Deploy producción
- **Push a `develop`** → Build → Push Docker Hub → Deploy staging
- **PR** → Build → Tests

### Variables y Secrets

| Variable | Ambiente | Descripción |
|----------|----------|-------------|
| {{ DATABASE_URL }} | {{ Todos }} | {{ Conexión a base de datos }} |
| {{ API_KEY }} | {{ Producción }} | {{ API key del servicio X }} |

## Estructura del Proyecto

```
{{ nombre-del-repo }}/
├── .github/
│   └── workflows/       # Pipelines CI/CD
├── src/                  # Código fuente
├── tests/                # Tests
├── docker-compose.yml    # Configuración Docker
├── Dockerfile            # Build de la imagen
├── .env.example          # Variables de entorno de ejemplo
└── README.md             # Este archivo
```

## Contribución

Consulta la [Guía de Contribución](https://github.com/GoEcosystemDH/.github/blob/main/CONTRIBUTING.md) y las [Convenciones de Nombres](https://wiki.goecosystemdh.com/s/onboarding).

### Flujo rápido

```bash
git checkout develop && git pull
git checkout -b feature/mi-funcionalidad
# ... desarrollar ...
git push -u origin feature/mi-funcionalidad
gh pr create
```

## Contacto

| Rol | Equipo |
|-----|--------|
| **Owner** | {{ Equipo responsable }} |
| **Planificación** | [Azure DevOps](https://dev.azure.com/goecosystem/Go-Devops/_workitems/) |
| **Documentación** | [Wiki GoEcosystemDH](https://wiki.goecosystemdh.com) |

---

> Parte del ecosistema [GoEcosystemDH](https://github.com/GoEcosystemDH) — Soluciones tecnológicas para salud digital.
