ifeq ($(OS),Windows_NT)
	maven = mvnw.cmd
	docker_build_cmd = make build && docker build -t maven-docker-pipeline:latest .
else
	maven = ./mvnw
	docker_build_cmd = $(maven) clean package -Pdocker
endif


ifeq ($(OS),Windows_NT)
else
endif

build: ## Build the application with mvn clean package
	$(maven) clean package

docker-build: ## Build the application as a docker image
	$(docker_build_cmd)

run: ## Run the application
	java -jar target/maven-docker-pipeline.jar

help: ## This help dialog.
	@echo "Usage: make [target]. Find the available targets below:"
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed 's/:.*##\s*/:/' | column -c2 -t -s :)"
