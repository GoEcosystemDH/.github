[![Board Status](https://dev.azure.com/goecosystem/e2a0dcc4-b0e3-4bd5-95c7-eddf5dd341b3/c543c47e-2ebf-449c-b4bf-f9caf5990811/_apis/work/boardbadge/48e2da7d-668b-43a7-b2d3-bd23a884d66b)](https://dev.azure.com/goecosystem/e2a0dcc4-b0e3-4bd5-95c7-eddf5dd341b3/_boards/board/t/c543c47e-2ebf-449c-b4bf-f9caf5990811/Microsoft.RequirementCategory)
# .github — GoEcosystemDH

Repositorio organizacional con templates, guías y configuración global para todos los repos de [GoEcosystemDH](https://github.com/GoEcosystemDH).

## Contenido

| Archivo | Propósito |
|---------|-----------|
| `profile/README.md` | Página de perfil de la organización |
| `CONTRIBUTING.md` | Guía de contribución para desarrolladores |
| `CODE_OF_CONDUCT.md` | Código de conducta del equipo |
| `SECURITY.md` | Política de seguridad y reporte de vulnerabilidades |
| `.github/ISSUE_TEMPLATE/` | Templates globales para Issues (bug, feature) |
| `.github/pull_request_template.md` | Template global para Pull Requests |
| `.github/dependabot.yml` | Configuración de Dependabot |
| `workflow-templates/` | Workflow templates organizacionales para GitHub Actions |

## Convenciones Rápidas

### Nombres de Repos

- **Formato:** `[prefijo]-[nombre][-sufijo]` en kebab-case
- **Prefijos:** `his-` (HIS), `rcf-` (RCF), `cmi-` (CMI), `app-` (apps), `ct-` (Cero Trámites)
- **Sufijos:** `-api`, `-app`, `-web`, `-android`, `-services`, `-infra`, `-docs`
- **Detalle completo:** [Convención de Nombres en Wiki](https://wiki.goecosystemdh.com/s/onboarding)

### Branches

- `main` — producción (default, protegida)
- `develop` — integración (protegida)
- `feature/*` — nuevas funcionalidades
- `hotfix/*` — correcciones urgentes
- `release/*` — preparación de releases
- **Detalle completo:** [Política de Branches en Wiki](https://wiki.goecosystemdh.com/s/onboarding)

### Commits

Usamos Conventional Commits: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`, `ci:`, `perf:`

## Documentación Completa

Toda la documentación detallada está en la wiki:

- [Onboarding Desarrollo](https://wiki.goecosystemdh.com/s/onboarding) — Guía completa para nuevos desarrolladores
- [Azure DevOps](https://dev.azure.com/goecosystem/Go-Devops) — Planificación y seguimiento de tareas
