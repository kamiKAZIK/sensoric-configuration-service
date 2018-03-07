# docker run --name sensoric-configuration-service -p38888:38888 \
    -v$HOME/git/kami/sensoric/encrypt:/usr/local/applications/encrypt \
    -it -d com.sensoric/sensoric-configuration-service \
    --spring.profiles.active=??? \
    --encrypt.key-store.location=??? \
    --encrypt.key-store.password=??? \
    --encrypt.key-store.alias=??? \
    --encrypt.key-store.secret=???

FROM java:alpine
RUN mkdir -p /usr/local/applications && \
    sed -i "s/\(securerandom\.source=\).*\$/\1file\:\/dev\/urandom/" $JAVA_HOME/jre/lib/security/java.security
WORKDIR /usr/local/applications
ARG JAR_FILE
ADD ${JAR_FILE} sensoric-configuration-service.jar
EXPOSE 38888
ENTRYPOINT ["java", "-jar", "-Xmx32m", "-Xss256k", "sensoric-configuration-service.jar"]
