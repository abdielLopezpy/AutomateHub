#!/bin/bash

# Script para crear el repositorio AutomateHub con estructura de categorías, README.md, LICENSE, .gitignore y Makefile

# Función para mostrar mensajes de error
function error_exit {
    echo "$1" 1>&2
    exit 1
}

# Verificar si Git está instalado
command -v git >/dev/null 2>&1 || error_exit "Git no está instalado. Por favor, instala Git y vuelve a intentarlo."

# Verificar si Make está instalado
command -v make >/dev/null 2>&1 || error_exit "Make no está instalado. Por favor, instala Make y vuelve a intentarlo."

# Opcional: Verificar si GitHub CLI está instalado
if command -v gh >/dev/null 2>&1; then
    GH_CLI=true
else
    GH_CLI=false
    echo "GitHub CLI no está instalado. Puedes instalarlo para crear el repositorio en GitHub automáticamente."
fi

# Nombre del repositorio
REPO_NAME="AutomateHub"

# Directorios de categorías por lenguaje
CATEGORIES=("bash" "python" "ruby" "perl" "templates" "herramientas")

# Archivos a crear
README_FILE="README.md"
LICENSE_FILE="LICENSE"
GITIGNORE_FILE=".gitignore"
MAKEFILE="Makefile"

# Contenido de la licencia MIT
MIT_LICENSE=$(cat <<EOF
MIT License

Copyright (c) $(date +"%Y") [Tu Nombre]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

El aviso de copyright y este aviso de permiso se incluirán en todas
las copias o partes sustanciales del Software.

EL SOFTWARE SE PROPORCIONA "TAL CUAL", SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O
IMPLÍCITA, INCLUYENDO PERO NO LIMITADO A LAS GARANTÍAS DE COMERCIABILIDAD,
ADECUACIÓN PARA UN PROPÓSITO PARTICULAR Y NO INFRACCIÓN. EN NINGÚN CASO LOS
AUTORES O LOS TITULARES DEL COPYRIGHT SERÁN RESPONSABLES DE NINGUNA RECLAMACIÓN,
DAÑOS O OTRAS RESPONSABILIDADES, YA SEA EN UNA ACCIÓN CONTRACTUAL, AGRAVIO O
DE OTRO MODO, QUE SURJAN DE, FUERA DE O EN CONEXIÓN CON EL SOFTWARE O EL USO
U OTROS TRATOS EN EL SOFTWARE.
EOF
)

# Contenido de .gitignore básico
GITIGNORE_CONTENT=$(cat <<EOF
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
*.egg-info/
.installed.cfg
*.egg

# PyInstaller
#  Usually these files are written by a python script from a template
#  before PyInstaller builds the exe, so as to inject date/other infos into it.
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/

# Translations
*.mo
*.pot

# Django stuff:
*.log
local_settings.py
db.sqlite3

# Flask stuff:
instance/
.webassets-cache

# Scrapy stuff:
.scrapy

# Sphinx documentation
docs/_build/

# PyBuilder
target/

# Jupyter Notebook
.ipynb_checkpoints

# IPython
profile_default/
ipython_config.py

# pyenv
.python-version

# celery beat schedule file
celerybeat-schedule

# dotenv
.env
.env.*

# virtualenv
venv/
ENV/
env/
env.bak/
venv.bak/

# Spyder project settings
.spyderproject
.spyproject

# Rope project settings
.ropeproject

# mkdocs documentation
/site

# mypy
.mypy_cache/
EOF
)

# Contenido del Makefile
MAKEFILE_CONTENT=$(cat <<'EOF'
# Makefile para automatizar la actualización del README.md con categorías

# Variables
README=README.md
LICENSE=LICENSE
CATEGORIES=$(shell ls -d */ | sed 's#/##')

# Target por defecto
all: update-readme

# Actualizar el README.md
update-readme: $(README)
	@echo "Actualizando README.md..."
	@echo "# AutomateHub" > $(README)
	@echo "" >> $(README)
	@echo "Bienvenido a **AutomateHub**. Este repositorio es una plataforma dedicada a compartir templates, scripts de automatización y otros recursos útiles para desarrolladores y entusiastas de la automatización." >> $(README)
	@echo "" >> $(README)
	@echo "## Índice" >> $(README)
	@echo "- [Descripción](#descripción)" >> $(README)
	@echo "- [Categorías](#categorías)" >> $(README)
	@echo "- [Instalación](#instalación)" >> $(README)
	@echo "- [Uso](#uso)" >> $(README)
	@echo "- [Contribuciones](#contribuciones)" >> $(README)
	@echo "- [Licencia](#licencia)" >> $(README)
	@echo "" >> $(README)
	@echo "## Descripción" >> $(README)
	@echo "AutomateHub es una colección de recursos que incluyen scripts de automatización, plantillas de proyectos, configuraciones y herramientas de desarrollo diseñadas para mejorar la eficiencia y productividad de los desarrolladores." >> $(README)
	@echo "" >> $(README)
	@echo "## Categorías" >> $(README)
	@echo "" >> $(README)

	# Iterar sobre cada categoría y listar sus contenidos
	@for category in $(CATEGORIES); do \
		echo "### $$category" >> $(README); \
		echo "" >> $(README); \
		if [ -d "$$category/scripts" ]; then \
			echo "**Scripts:**" >> $(README); \
			echo "" >> $(README); \
			for script in $$category/scripts/*; do \
				if [ -f "$$script" ]; then \
					echo "- [`$$script`](./$$script)" >> $(README); \
				fi; \
			done >> $(README); \
			echo "" >> $(README); \
		fi; \
		if [ -d "$$category/templates" ]; then \
			echo "**Templates:**" >> $(README); \
			echo "" >> $(README); \
			for template in $$category/templates/*; do \
				if [ -d "$$template" ]; then \
					echo "- [`$$template`](./$$template)" >> $(README); \
				elif [ -f "$$template" ]; then \
					echo "- [`$$template`](./$$template)" >> $(README); \
				fi; \
			done >> $(README); \
			echo "" >> $(README); \
		fi; \
	done

	@echo "## Instalación" >> $(README)
	@echo "Para clonar este repositorio, utiliza el siguiente comando:" >> $(README)
	@echo "" >> $(README)
	@echo "```bash" >> $(README)
	@echo "git clone https://github.com/tu_usuario/AutomateHub.git" >> $(README)
	@echo "```" >> $(README)
	@echo "" >> $(README)
	@echo "## Uso" >> $(README)
	@echo "Explora las categorías para encontrar scripts y plantillas que se ajusten a tus necesidades. Cada archivo o carpeta incluye una descripción detallada de su propósito y cómo utilizarlo." >> $(README)
	@echo "" >> $(README)
	@echo "## Contribuciones" >> $(README)
	@echo "Las contribuciones son bienvenidas. Por favor, revisa las [directrices de contribución](CONTRIBUTING.md) antes de enviar una pull request." >> $(README)
	@echo "" >> $(README)
	@echo "## Licencia" >> $(README)
	@echo "Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles." >> $(README)
	@echo "" >> $(README)
	@echo "AutomateHub se esfuerza por mantener recursos de alta calidad y fomentar una comunidad colaborativa." >> $(README)

	@echo "README.md actualizado correctamente."

# Crear README.md si no existe
$(README):
	@touch $(README)

.PHONY: all update-readme

EOF
)

# Contenido inicial de README.md
README_CONTENT=$(cat <<EOF
# $REPO_NAME

Bienvenido a **$REPO_NAME**. Este repositorio es parte de AutomateHub, una plataforma dedicada a compartir templates, scripts de automatización y otros recursos útiles para desarrolladores y entusiastas de la automatización.

## Descripción

[Proporciona una descripción detallada de tu proyecto aquí.]

## Índice

- [Instalación](#instalación)
- [Uso](#uso)
- [Contribuciones](#contribuciones)
- [Licencia](#licencia)

## Instalación

[Instrucciones para instalar y configurar tu proyecto.]

## Uso

[Ejemplos de cómo utilizar tu proyecto.]

## Contribuciones

Las contribuciones son bienvenidas. Por favor, revisa las [directrices de contribución](CONTRIBUTING.md) antes de enviar una pull request.

## Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.
EOF
)

# Función para crear directorios y subdirectorios
function crear_directorios {
    for categoria in "${CATEGORIES[@]}"; do
        mkdir -p "$categoria/scripts" "$categoria/templates"
    done
}

# Función para crear archivos
function crear_archivos {
    # Crear README.md
    if [ ! -f "$README_FILE" ]; then
        echo "$README_CONTENT" > "$README_FILE"
        echo "Archivo $README_FILE creado."
    else
        echo "El archivo $README_FILE ya existe. Se omitirá la creación."
    fi

    # Crear LICENSE
    if [ ! -f "$LICENSE_FILE" ]; then
        echo "$MIT_LICENSE" > "$LICENSE_FILE"
        echo "Archivo $LICENSE_FILE creado."
    else
        echo "El archivo $LICENSE_FILE ya existe. Se omitirá la creación."
    fi

    # Crear .gitignore
    if [ ! -f "$GITIGNORE_FILE" ]; then
        echo "$GITIGNORE_CONTENT" > "$GITIGNORE_FILE"
        echo "Archivo $GITIGNORE_FILE creado."
    else
        echo "El archivo $GITIGNORE_FILE ya existe. Se omitirá la creación."
    fi

    # Crear Makefile
    if [ ! -f "$MAKEFILE" ]; then
        echo "$MAKEFILE_CONTENT" > "$MAKEFILE"
        echo "Archivo $MAKEFILE creado."
    else
        echo "El archivo $MAKEFILE ya existe. Se omitirá la creación."
    fi
}

# Función para inicializar Git y realizar el primer commit
function inicializar_git {
    git add .
    git commit -m "Inicializa AutomateHub con estructura básica, README.md, LICENSE, .gitignore y Makefile"
    echo "Repositorio Git inicializado y primer commit realizado."
}

# Función para crear el repositorio en GitHub usando GitHub CLI
function crear_repositorio_github {
    if [ "$GH_CLI" = true ]; then
        echo "Creando repositorio en GitHub..."
        gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
        echo "Repositorio $REPO_NAME creado en GitHub y conectado como remoto 'origin'."
    else
        echo "GitHub CLI no está instalado. Salta la creación del repositorio en GitHub."
    fi
}

# Función principal
function main {
    echo "=== Creación del repositorio $REPO_NAME ==="

    # Crear directorios
    crear_directorios

    # Crear archivos
    crear_archivos

    # Inicializar Git
    git init
    inicializar_git

    # Crear repositorio en GitHub (opcional)
    crear_repositorio_github

    echo "Repositorio $REPO_NAME configurado exitosamente."
}

# Ejecutar la función principal
main
