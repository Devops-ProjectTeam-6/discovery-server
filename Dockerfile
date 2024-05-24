# Start with a base image
FROM openjdk:17-jdk-alpine3.14

# Set working directory in the container
WORKDIR /app
CMD ["./gradlew", "clean", "bootJar"]
COPY build/libs/*.jar app.jar
