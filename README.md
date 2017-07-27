# Build and test a docker image with maven using Travis CI

A sample project that demonstrates the usage of dockerfile maven plugin within a continuous delivery pipeline run with travis ci.

## Project Structure

### Maven

[Apache Maven](http://maven.apache.org) is used as the build automation tool, and is configured to run unit tests, build docker image and run acceptance tests against this docker image using different profiles. See [Usage](#usage) section for more information about the maven commands to use.

This project maven execution is based on a [maven wrapper](https://github.com/takari/maven-wrapper), meaning that you do not need to have maven installed on your local machine.

### Spring project

This project has been created from [Spring Initializr](https://start.spring.io/), and consists of a simple [Spring Boot](http://projects.spring.io/spring-boot/) application with a single controller that returns `Hello World!` text when calling [http://localhost:8080](http://localhost:8080) url.

### Dockerfile-maven plugin

The [dockerfile-maven](https://github.com/spotify/dockerfile-maven) plugin used to build the docker image through maven execution requires a Dockerfile definition. The Dockerfile used in this project just copy the built `jar` file and run it as its default command.

### Docker-compose

[Docker compose](https://docs.docker.com/compose/) is used during acceptance testing execution to run the environment under test.

### Travis CI

[Travis CI](https://travis-ci.org) is a continuous integration service used to build and test software projects hosted at Github.

This project defines a `.travis.yml` file containing the travis configuration to build and run acceptance tests.

## Usage

The following sections propose to use `make` commands to run the different build goals. `make` is available by default on unix based systems, and can be installed on Windows from this [site](http://gnuwin32.sourceforge.net/packages/make.htm).

### Build

#### Default build

From `maven-docker-pipeline` project folder, execute either `make`, `make build` or `mvn clean package` command. The latter command will be used in all cases to run the build.

This build results in a `maven-docker-pipeline.jar` file located in `./target/` folder. See [Running jar](#running-jar) section to know how to run the built jar.

#### Docker image build

From `maven-docker-pipeline` project folder, execute either `make docker-build` or `mvn clean package -Pdocker` command. The latter command will be used in all cases to run the build. The default profile will skip the docker image creation.

This build execution uses the [Maven Dockerfile Plugin](https://github.com/spotify/dockerfile-maven) to create a docker image based on a `openjdk:8-alpine` image. More information about this build execution can be found in `maven-docker-pipeline/pom.xml` and `maven-docker-pipeline/Dockerfile` files. See [Running with docker-compose](#running-with-docker-compose) to know how to run the built docker image.

> Note : dockerfile-maven plugin does not seem to work Docker for Windows. For this reason, the `mvn clean package -Pdocker` command is prohibited on Windows, and the `make docker-build` goal is configured to run a `make build` goal, then call a docker command directly to build a docker image.

### Execution

#### Running jar

Once the jar file build ends successfully (see [Default build](#default-build) section), the application can be started using `make run` or `java -jar target/maven-docker-pipeline.jar` command. The latter will be used in all cases to run the application.

Once started, the application will be available at [http://localhost:8080](http://localhost:8080).

#### Running with docker-compose

Once the docker image build ends successfully (see [Docker image build](#docker-image-build) section), a docker environment can be executed using `make up` or `cd docker && docker-compose up -d` command. The latter command will be used in all cases to run the docker containers. The `docker-compose` configuration file is located at `maven-docker-pipeline/docker/docker-compose.yml`.

The docker environment can be stopped using `make down` or `cd docker && docker-compose down` command. The latter command will be used in all cases.

## Acceptance tests

From `maven-docker-pipeline` project folder, execute either `make test` or `mvn verify -Pat` command. The latter command will be used in all cases to run the build. The default profile will skip the acceptance tests execution.
