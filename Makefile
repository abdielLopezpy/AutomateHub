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
