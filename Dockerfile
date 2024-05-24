# Start with a base image
FROM openjdk:17-jdk-alpine3.14

# Set working directory in the container
WORKDIR /app
COPY --chown=gradle:gradle build.gradle settings.gradle ./
COPY --chown=gradle:gradle src ./src
CMD ["./gradlew", "clean", "bootJar"]
COPY build/libs/*.jar app.jar
