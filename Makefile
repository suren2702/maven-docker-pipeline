ifeq ($(OS),Windows_NT)
	maven = mvnw.cmd
else
	maven = ./mvnw
endif

build: ## Build the application with mvn clean package
	$(maven) clean package

run: ## Run the application
	java -jar target/maven-docker-pipeline.jar

help: ## This help dialog.
	@echo "Usage: make [target]. Find the available targets below:"
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed 's/:.*##\s*/:/' | column -c2 -t -s :)"
