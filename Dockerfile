FROM openjdk:17-jdk-alpine
MAINTAINER Rahman Usta
ENV shell="/bin/sh -i"
COPY target/cloudterm.jar /opt/cloudterm/
CMD ["java","-jar","/opt/cloudterm/cloudterm.jar"]
EXPOSE 8080
