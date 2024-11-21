# Stage 1: Build
FROM maven:3.9.4-eclipse-temurin-21 AS build
LABEL authors="renan-fig"
LABEL description="This is the Dockerfile for the Projetorest service"

# Set the working directory
WORKDIR /app

# Copy only essential files first (optimize build cache)
COPY pom.xml mvnw ./
COPY .mvn .mvn

# Ensure the wrapper is executable
RUN chmod +x mvnw

# Download dependencies
RUN ./mvnw dependency:go-offline -B

# Copy the source code and build the application
COPY src src
RUN ./mvnw clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:21-jre

# Set the working directory
WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/projetorest-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8081

# Define the entrypoint
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
