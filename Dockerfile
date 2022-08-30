FROM openjdk:8-jdk-alpine
ADD target/frontendApplication.jar frontendApplication.jar
EXPOSE 8083
ENTRYPOINT ["java", "-jar", "frontendApplication.jar"]
