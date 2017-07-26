FROM openjdk:8-alpine
WORKDIR /srv
COPY ./target/maven-docker-pipeline.jar maven-docker-pipeline.jar
CMD java -jar maven-docker-pipeline.jar