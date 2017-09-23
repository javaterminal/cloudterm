FROM openjdk:9-jdk-slim
MAINTAINER Rahman Usta
ENV shell="/usr/bin/jshell"
#RUN apt-get update -y && apt-get install sudo iptables iputils-ping -y
VOLUME /tmp
WORKDIR /opt/cloudterm/
COPY target/cloudterm.jar .
COPY ./restrict_fs.sh .
#RUN ./restrict_fs.sh
USER nobody
CMD ["java","-Djava.util.prefs.systemRoot=/tmp/.systemRoot","-Djava.util.prefs.userRoot=/tmp/.userRoot","-jar","./cloudterm.jar"]
EXPOSE 8080