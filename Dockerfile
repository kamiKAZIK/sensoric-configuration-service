FROM java:alpine
RUN mkdir -p /usr/local/applications
WORKDIR /usr/local/applications
ARG JAR_FILE
ADD ${JAR_FILE} sensoric-configuration-service.jar
EXPOSE 38888
ENTRYPOINT ["java", "-jar", "-Xmx128m", "-Xss512k", "sensoric-configuration-service.jar"]
