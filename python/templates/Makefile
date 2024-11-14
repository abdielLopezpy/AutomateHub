# Copyright 2024 Abdiel Lopez
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     https://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Makefile para proyectos Django
# Este Makefile automatiza tareas comunes en el desarrollo de aplicaciones Django.

# -------------------------------
# Variables
# -------------------------------

# Directorio del entorno virtual
VENV_DIR=venv

# Comandos dentro del entorno virtual
PYTHON=$(VENV_DIR)/bin/python
PIP=$(VENV_DIR)/bin/pip
DJANGO_MANAGE=$(PYTHON) manage.py

# Archivo de dependencias
REQUIREMENTS=requirements.txt

# Docker (Opcional)
DOCKER_IMAGE=automatehub_django
DOCKER_CONTAINER=automatehub_django_container
PORT=8000

# -------------------------------
# Targets Phony
# -------------------------------
.PHONY: help setup venv install run migrate createsuperuser test lint clean collectstatic shell format coverage docker-build docker-run docker-stop

# -------------------------------
# Target: help
# -------------------------------
# Muestra esta ayuda
help:
	@echo "Makefile para proyectos Django"
	@echo ""
	@echo "Uso: make [target]"
	@echo ""
	@echo "Targets disponibles:"
	@echo "  help               Muestra esta ayuda"
	@echo "  setup              Configura el entorno de desarrollo completo"
	@echo "  venv               Crea el entorno virtual"
	@echo "  install            Instala las dependencias del proyecto"
	@echo "  run                Ejecuta el servidor de desarrollo"
	@echo "  migrate            Aplica las migraciones de la base de datos"
	@echo "  createsuperuser    Crea un superusuario para el admin de Django"
	@echo "  test               Ejecuta las pruebas unitarias"
	@echo "  lint               Linting del código con flake8"
	@echo "  format             Formatea el código con black"
	@echo "  coverage           Muestra el reporte de cobertura de pruebas"
	@echo "  clean              Elimina archivos temporales y compilados"
	@echo "  collectstatic      Recopila los archivos estáticos"
	@echo "  shell              Abre el shell interactivo de Django"
	@echo "  docker-build       Construye la imagen de Docker"
	@echo "  docker-run         Ejecuta el contenedor de Docker"
	@echo "  docker-stop        Detiene el contenedor de Docker"

# -------------------------------
# Target: setup
# -------------------------------
# Configura el entorno de desarrollo completo
setup: venv install migrate

# -------------------------------
# Target: venv
# -------------------------------
# Crea el entorno virtual
venv:
	@echo "Creando entorno virtual en $(VENV_DIR)/..."
	python3 -m venv $(VENV_DIR)
	@echo "Entorno virtual creado."

# -------------------------------
# Target: install
# -------------------------------
# Instala las dependencias del proyecto
install: venv
	@echo "Instalando dependencias desde $(REQUIREMENTS)..."
	$(PIP) install --upgrade pip
	$(PIP) install -r $(REQUIREMENTS)
	@echo "Dependencias instaladas."

# -------------------------------
# Target: run
# -------------------------------
# Ejecuta el servidor de desarrollo
run: migrate
	@echo "Iniciando el servidor de desarrollo en el puerto $(PORT)..."
	$(DJANGO_MANAGE) runserver 0.0.0.0:$(PORT)

# -------------------------------
# Target: migrate
# -------------------------------
# Aplica las migraciones de la base de datos
migrate:
	@echo "Aplicando migraciones..."
	$(DJANGO_MANAGE) migrate

# -------------------------------
# Target: createsuperuser
# -------------------------------
# Crea un superusuario para el admin de Django
createsuperuser:
	@echo "Creando superusuario..."
	$(DJANGO_MANAGE) createsuperuser

# -------------------------------
# Target: test
# -------------------------------
# Ejecuta las pruebas unitarias
test:
	@echo "Ejecutando pruebas unitarias..."
	$(DJANGO_MANAGE) test

# -------------------------------
# Target: lint
# -------------------------------
# Linting del código con flake8
lint:
	@echo "Ejecutando linting con flake8..."
	$(VENV_DIR)/bin/flake8 .

# -------------------------------
# Target: format
# -------------------------------
# Formatea el código con black
format:
	@echo "Formateando el código con black..."
	$(VENV_DIR)/bin/black .

# -------------------------------
# Target: coverage
# -------------------------------
# Muestra el reporte de cobertura de pruebas
coverage:
	@echo "Ejecutando pruebas con cobertura..."
	$(VENV_DIR)/bin/coverage run --source='.' manage.py test
	$(VENV_DIR)/bin/coverage report

# -------------------------------
# Target: clean
# -------------------------------
# Elimina archivos temporales y compilados
clean:
	@echo "Eliminando archivos temporales y compilados..."
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	rm -rf $(VENV_DIR)/__pycache__
	rm -rf *.egg-info
	rm -rf build/
	rm -rf dist/
	rm -rf .coverage
	rm -rf htmlcov/
	@echo "Archivos temporales eliminados."

# -------------------------------
# Target: collectstatic
# -------------------------------
# Recopila los archivos estáticos
collectstatic:
	@echo "Recopilando archivos estáticos..."
	$(DJANGO_MANAGE) collectstatic --noinput

# -------------------------------
# Target: shell
# -------------------------------
# Abre el shell interactivo de Django
shell:
	@echo "Abriendo el shell interactivo de Django..."
	$(DJANGO_MANAGE) shell

# -------------------------------
# Target: docker-build
# -------------------------------
# Construye la imagen de Docker
docker-build:
	@echo "Construyendo la imagen de Docker..."
	docker build -t $(DOCKER_IMAGE) .

# -------------------------------
# Target: docker-run
# -------------------------------
# Ejecuta el contenedor de Docker
docker-run:
	@echo "Ejecutando el contenedor de Docker..."
	docker run -d -p $(PORT):8000 --name $(DOCKER_CONTAINER) $(DOCKER_IMAGE)

# -------------------------------
# Target: docker-stop
# -------------------------------
# Detiene el contenedor de Docker
docker-stop:
	@echo "Deteniendo y eliminando el contenedor de Docker..."
	docker stop $(DOCKER_CONTAINER) || true
	docker rm $(DOCKER_CONTAINER) || true
	@echo "Contenedor de Docker detenido y eliminado."

# -------------------------------
# Target: docker-shell
# -------------------------------
# Abre una shell en el contenedor de Docker
docker-shell:
	@echo "Abriendo shell en el contenedor de Docker..."
	docker exec -it $(DOCKER_CONTAINER) /bin/bash

# -------------------------------
# Reglas auxiliares
# -------------------------------

# Verificar si el entorno virtual está creado
$(VENV_DIR)/bin/activate: $(VENV_DIR)
	@echo "Entorno virtual creado. Puedes activarlo con 'source $(VENV_DIR)/bin/activate'"

