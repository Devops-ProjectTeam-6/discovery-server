# Start with a base image
FROM openjdk:17-jdk-alpine3.14

# Set working directory in the container
WORKDIR /app

# Copy gradle execution file
COPY gradlew . 

# Copy gradle configuration files
COPY gradle gradle 

# Copy build script
COPY build.gradle .

# Give permissions to gradle execution file to be executable
RUN chmod +x ./gradlew 

# Download dependencies
RUN ./gradlew clean build -x test --continue

# Copy your source code in the container
COPY src src

# Build the application
RUN ./gradlew build -x test

# Start with a base image for running the application
FROM openjdk:17-jdk-alpine3.14 

# Set application home
ENV APP_HOME /app

# Create the app directory
RUN mkdir $APP_HOME 

# Set the application home as workdir
WORKDIR $APP_HOME 

# Copy the application built in the previous step
COPY --from=0 /app/build/libs/*.jar ./app.jar 

# Here, you can specify environmental vars for your application if any,

# Expose the server port if required
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
