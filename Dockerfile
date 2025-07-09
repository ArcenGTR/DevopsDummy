FROM openjdk:17
EXPOSE 8080
ADD target/DevOpsDummy.jar DevOpsDummy.jar
ENTRYPOINT ["java", "-jar", "/DevOpsDummy.jar"]