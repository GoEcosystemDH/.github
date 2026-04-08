#!/usr/bin/env bash
# ============================================================
# GoEcosystemDH — Setup de Nuevo Repositorio
# ============================================================
# Crea un repositorio con toda la estructura estandar:
#   - Branches: main + develop (default)
#   - Teams: DevOps-Infra (admin) + Development (push)
#   - Workflows: auto-PR, pr-metadata, labeler, pr-size
#   - Config: .gitignore, .env.example, labeler.yml
#   - Settings: auto-delete branches, descripcion
#
# Uso:
#   ./create-repo.sh nombre-del-repo "Descripcion del proyecto"
#
# Prerequisitos:
#   - gh CLI autenticado con permisos de admin en GoEcosystemDH
# ============================================================

set -euo pipefail

ORG="GoEcosystemDH"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

if [ $# -lt 2 ]; then
  echo -e "${RED}Uso: $0 <nombre-repo> \"<descripcion>\"${NC}"
  echo "Ejemplo: $0 mi-proyecto \"API de gestion de inventarios\""
  exit 1
fi

REPO_NAME="$1"
REPO_DESC="$2"

if ! echo "$REPO_NAME" | grep -qE '^[a-z0-9]+(-[a-z0-9]+)*$'; then
  echo -e "${RED}Error: nombre debe ser kebab-case (ej: mi-nuevo-proyecto)${NC}"
  exit 1
fi

echo -e "${BLUE}══════════════════════════════════════════════${NC}"
echo -e "${BLUE}  GoEcosystemDH — Setup de Nuevo Repositorio${NC}"
echo -e "${BLUE}══════════════════════════════════════════════${NC}"
echo -e "  Repo: ${GREEN}$REPO_NAME${NC} | Desc: ${GREEN}$REPO_DESC${NC}"
echo ""

# --- 1. Crear repositorio ---
echo -e "${YELLOW}[1/8] Creando repositorio...${NC}"
gh repo create "$ORG/$REPO_NAME" --private --description "$REPO_DESC" 2>&1
echo -e "${GREEN}  ✓ Repositorio creado${NC}"

# --- 2. Crear estructura inicial ---
echo -e "${YELLOW}[2/8] Creando estructura inicial...${NC}"
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"
git init -q
git remote add origin "https://github.com/$ORG/$REPO_NAME.git"

cat > README.md << READMEEOF
# $REPO_NAME

$REPO_DESC

## Requisitos

- Docker & Docker Compose v2

## Instalacion local

\`\`\`bash
git clone https://github.com/$ORG/$REPO_NAME.git
cd $REPO_NAME
cp .env.example .env
\`\`\`

## Variables de entorno

Ver \`.env.example\` para la lista completa.

## Contacto

- **Owner:** DevOps-Infra
- **Organizacion:** $ORG
READMEEOF

cat > .gitignore << 'IGNEOF'
# Environment
.env
.env.local
.env.production.local

# Dependencies
/node_modules
/vendor
composer.lock

# Build
/build
/dist

# OS
.DS_Store
Thumbs.db

# IDE
.idea/
.vscode/
*.swp

# Logs
*.log
application/logs/*
!application/logs/index.html

# Cache
application/cache/*
!application/cache/index.html

# Legacy
.gitlab-ci.yml
IGNEOF

cat > .env.example << 'ENVEOF'
# ============================================
# Variables de entorno
# ============================================
# Copiar a .env y ajustar valores
ENVEOF

mkdir -p .github/workflows

cat > .github/labeler.yml << 'LABEOF'
docker:
  - changed-files:
    - any-glob-to-any-file:
      - "Dockerfile*"
      - "docker-compose*.yml"
      - ".dockerignore"
ci-cd:
  - changed-files:
    - any-glob-to-any-file:
      - ".github/workflows/**"
      - ".github/actions/**"
documentacion:
  - changed-files:
    - any-glob-to-any-file:
      - "**/*.md"
      - "docs/**"
dependencias:
  - changed-files:
    - any-glob-to-any-file:
      - "package.json"
      - "package-lock.json"
      - "composer.json"
      - "go.mod"
      - "go.sum"
      - "requirements.txt"
configuracion:
  - changed-files:
    - any-glob-to-any-file:
      - "*.yml"
      - "*.yaml"
      - "*.json"
      - "*.toml"
      - ".env.example"
LABEOF

cat > .github/workflows/auto-pr-to-main.yml << 'APREOF'
name: "Auto PR: develop → main"
on:
  push:
    branches: [develop]
permissions:
  contents: read
  pull-requests: write
  issues: write
jobs:
  create-or-update-pr:
    name: Sync develop → main
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
          ref: develop
      - name: Check for diff and create/update PR
        uses: actions/github-script@v7
        with:
          script: |
            const { owner, repo } = context.repo;
            let comparison;
            try { comparison = await github.rest.repos.compareCommitsWithBasehead({ owner, repo, basehead: 'main...develop' }); } catch (e) { return; }
            const commits = comparison.data.commits;
            if (commits.length === 0) return;
            const table = commits.slice(-30).map(c => `| \`${c.sha.substring(0,7)}\` | ${c.author ? `@${c.author.login}` : c.commit.author.name} | ${c.commit.message.split('\n')[0].substring(0,80)} | ${c.commit.author.date.substring(0,10)} |`).join('\n');
            const cats = { feat:0, fix:0, refactor:0, chore:0, ci:0, docs:0, test:0, other:0 };
            commits.forEach(c => { const m = c.commit.message.toLowerCase(); const t = Object.keys(cats).find(k => m.startsWith(k+':') || m.startsWith(k+'(')); cats[t||'other']++; });
            const summary = Object.entries(cats).filter(([_,n]) => n>0).map(([t,n]) => `**${t}**: ${n}`).join(' | ');
            const body = `## 🔄 Sync: develop → main\n\n- **${commits.length} commits** | ${summary}\n\n| SHA | Autor | Mensaje | Fecha |\n|-----|-------|---------|-------|\n${table}\n\n---\n> 🤖 Auto-generado | <sub>v1.0</sub>`;
            const { data: prs } = await github.rest.pulls.list({ owner, repo, head: `${owner}:develop`, base: 'main', state: 'open' });
            const existing = prs.find(p => p.title.includes('sync:'));
            if (existing) { await github.rest.pulls.update({ owner, repo, pull_number: existing.number, body }); }
            else {
              try { await github.rest.issues.createLabel({ owner, repo, name: 'auto-sync', color: '0e8a16' }); } catch {}
              const { data: pr } = await github.rest.pulls.create({ owner, repo, title: 'sync: develop → main', head: 'develop', base: 'main', body });
              await github.rest.issues.addLabels({ owner, repo, issue_number: pr.number, labels: ['auto-sync'] });
            }
APREOF

cat > .github/workflows/pr-metadata.yml << 'METEOF'
name: PR Metadata Enrichment
on:
  pull_request:
    types: [opened, synchronize]
permissions:
  contents: read
  pull-requests: write
  issues: write
jobs:
  enrich:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with: { fetch-depth: 0 }
      - uses: actions/github-script@v7
        with:
          script: |
            const { owner, repo } = context.repo;
            const pr_number = context.payload.pull_request.number;
            const { data: files } = await github.rest.pulls.listFiles({ owner, repo, pull_number: pr_number, per_page: 300 });
            const paths = files.map(f => f.filename);
            const add = files.reduce((s,f) => s+f.additions, 0);
            const del = files.reduce((s,f) => s+f.deletions, 0);
            const total = add + del;
            const areas = new Set();
            const pats = { frontend:[/\.(jsx?|tsx?|vue|css|html)$/], backend:[/controllers\/|models\/|routes\/|services\//], api:[/api\/|swagger/], database:[/migration|\.sql$|database\.php/], infra:[/Dockerfile|docker-compose|\.github\/workflows/], config:[/\.env|config\/|\.yml$/], tests:[/test\/|\.test\.|\.spec\./], docs:[/\.md$|docs\//] };
            for (const [a, rs] of Object.entries(pats)) for (const f of paths) if (rs.some(r => r.test(f))) { areas.add(a); break; }
            let sz = 'XS'; if(total>500)sz='XL'; else if(total>200)sz='L'; else if(total>50)sz='M'; else if(total>10)sz='S';
            const mods = new Set(); paths.forEach(f => { const p=f.split('/'); if(p.length>=2) mods.add(p[0]==='src'?p[1]:p[0]); });
            const labels = [...areas].map(a=>`area:${a}`).concat(`size:${sz}`);
            for (const l of labels) { try { await github.rest.issues.getLabel({owner,repo,name:l}); } catch { const c={'area:frontend':'61dafb','area:backend':'68217a','area:api':'0052cc','area:database':'e6a817','area:infra':'333333','area:config':'c5def5','area:tests':'2ea44f','area:docs':'0075ca','size:XS':'009900','size:S':'77bb00','size:M':'eebb00','size:L':'ee9900','size:XL':'ee0000'}; await github.rest.issues.createLabel({owner,repo,name:l,color:c[l]||'ededed'}); } }
            await github.rest.issues.addLabels({ owner, repo, issue_number: pr_number, labels });
            const ft = paths.slice(0,15).map(f => { const d=files.find(x=>x.filename===f); return `| \`${f}\` | +${d.additions} -${d.deletions} | ${d.status} |`; }).join('\n');
            const body = `## 🤖 PR Metadata\n\n| Campo | Valor |\n|-------|-------|\n| **Repo** | \`${repo}\` |\n| **Areas** | ${[...areas].map(a=>`\`${a}\``).join(', ')||'N/A'} |\n| **Tamano** | ${sz} (+${add} -${del}, ${paths.length} archivos) |\n| **Modulos** | ${[...mods].slice(0,10).map(m=>`\`${m}\``).join(', ')} |\n\n| Archivo | Cambios | Estado |\n|---------|---------|--------|\n${ft}\n\n<sub>metadata-version: 1.0 | extractable: true</sub>`;
            const cmts = await github.rest.issues.listComments({owner,repo,issue_number:pr_number});
            const bot = cmts.data.find(c => c.user.type==='Bot' && c.body.includes('PR Metadata'));
            if (bot) await github.rest.issues.updateComment({owner,repo,comment_id:bot.id,body});
            else await github.rest.issues.createComment({owner,repo,issue_number:pr_number,body});
METEOF

cat > .github/workflows/labeler.yml << 'LWFEOF'
name: "Auto-labeler de PRs"
on:
  pull_request_target:
    types: [opened, synchronize, reopened]
permissions:
  contents: read
  pull-requests: write
jobs:
  label:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/labeler@v5
        with:
          configuration-path: .github/labeler.yml
          sync-labels: true
LWFEOF

cat > .github/workflows/pr-size.yml << 'PSZEOF'
name: "PR Size Label"
on:
  pull_request_target:
    types: [opened, synchronize, reopened]
permissions:
  pull-requests: write
jobs:
  size-label:
    runs-on: ubuntu-latest
    steps:
      - uses: codelytv/pr-size-labeler@v1
        with:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          xs_label: "size/XS"
          xs_max_size: 10
          s_label: "size/S"
          s_max_size: 50
          m_label: "size/M"
          m_max_size: 200
          l_label: "size/L"
          l_max_size: 500
          xl_label: "size/XL"
          fail_if_xl: false
          message_if_xl: "Este PR es **XL**. Considera dividirlo."
          files_to_ignore: "package-lock.json\ngo.sum\n*.lock"
PSZEOF

git add -A
GIT_AUTHOR_NAME="GoCarlosAndresSanchez" \
GIT_AUTHOR_EMAIL="GoCarlosAndresSanchez@users.noreply.github.com" \
GIT_COMMITTER_NAME="GoCarlosAndresSanchez" \
GIT_COMMITTER_EMAIL="GoCarlosAndresSanchez@users.noreply.github.com" \
git commit -q -m "feat: setup inicial del repositorio"
git branch -M main
git push -u origin main -q 2>&1
echo -e "${GREEN}  ✓ Estructura creada${NC}"

# --- 3-4. Crear develop y set default ---
echo -e "${YELLOW}[3/8] Creando develop y configurando default...${NC}"
SHA=$(gh api "repos/$ORG/$REPO_NAME/git/refs/heads/main" --jq '.object.sha')
gh api "repos/$ORG/$REPO_NAME/git/refs" -X POST -f ref=refs/heads/develop -f sha="$SHA" > /dev/null 2>&1
gh api "repos/$ORG/$REPO_NAME" -X PATCH -f default_branch=develop > /dev/null 2>&1
echo -e "${GREEN}  ✓ develop (default) + main${NC}"

# --- 5. Asignar teams ---
echo -e "${YELLOW}[4/8] Asignando teams...${NC}"
gh api "orgs/$ORG/teams/devops-infra/repos/$ORG/$REPO_NAME" -X PUT -f permission=admin > /dev/null 2>&1
gh api "orgs/$ORG/teams/development/repos/$ORG/$REPO_NAME" -X PUT -f permission=push > /dev/null 2>&1
echo -e "${GREEN}  ✓ DevOps-Infra (admin) + Development (push)${NC}"

# --- 6. Auto-delete ---
echo -e "${YELLOW}[5/8] Auto-delete branches on merge...${NC}"
gh api "repos/$ORG/$REPO_NAME" -X PATCH -f delete_branch_on_merge=true > /dev/null 2>&1
echo -e "${GREEN}  ✓ Activado${NC}"

# --- 7. Rulesets ---
echo -e "${YELLOW}[6/8] Verificando rulesets org...${NC}"
RULESETS=$(gh api "repos/$ORG/$REPO_NAME/rulesets" --jq '[.[].name] | join(", ")' 2>/dev/null)
echo -e "${GREEN}  ✓ $RULESETS${NC}"

# --- 8. Resumen ---
echo ""
echo -e "${BLUE}══════════════════════════════════════════════${NC}"
echo -e "${GREEN}  SETUP COMPLETADO${NC}"
echo -e "${BLUE}══════════════════════════════════════════════${NC}"
echo ""
echo "  Repo:       https://github.com/$ORG/$REPO_NAME"
echo "  Default:    develop"
echo "  Teams:      DevOps-Infra (admin), Development (push)"
echo "  Workflows:  auto-pr, pr-metadata, labeler, pr-size"
echo "  Rulesets:   $RULESETS"
echo ""
