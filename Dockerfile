# Stage 1: Build the application
FROM maven:3.8.4-openjdk-11-slim AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ /app/src/
RUN mvn package -DskipTests

# Stage 2: Package the application
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/spring-boot-docker-0.1.0.jar /app/spring-boot-docker.jar
EXPOSE 8080
CMD ["java", "-jar", "spring-boot-docker.jar"]
