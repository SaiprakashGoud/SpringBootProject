# Define the build stage
FROM maven:3.8.3-openjdk-17 AS build
# Copy the application's source code into the Docker image
COPY . .
# Run Maven build to compile the application and skip unit tests
RUN mvn clean package -Pprod -DskipTests

# Define the runtime stage
FROM openjdk:17-jdk-slim
# Copy the built .jar file from the build stage
COPY --from=build /target/DogsManagementSystem-0.0.1-SNAPSHOT.jar /DogsManagementSystem.jar
# Set the command to run the application when the Docker container starts
CMD ["java", "-jar", "/DogsManagementSystem.jar"]
