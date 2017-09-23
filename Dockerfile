FROM openjdk:9-jdk-slim
MAINTAINER Rahman Usta
ENV shell="/usr/bin/jshell"
#RUN apt-get update -y && apt-get install sudo iptables iputils-ping -y
VOLUME /tmp
WORKDIR /opt/cloudterm/
COPY target/cloudterm.jar .
COPY java.policy .
RUN useradd -ms /bin/bash tryjshell
RUN chmod -R  a-w / || true
RUN chmod -R  a+w /tmp || true
RUN chmod -R  a+w /home/tryjshell/ || true
RUN chmod -R  a+x /usr/bin/java || true
RUN chmod -R  a+x /usr/bin/jshell || true
USER tryjshell
CMD ["java","-Djava.security.manager","-Djava.security.policy=java.policy","-jar","./cloudterm.jar"]
EXPOSE 8080