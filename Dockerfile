FROM eclipse-temurin:17-jdk-slim

WORKDIR /app

ADD target/DevOpsDummy.jar DevOpsDummy.jar

RUN chmod +x app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/DevOpsDummy.jar"]