FROM openjdk:jre-alpine
ARG JAR_FILE
ENV ARTIFACT_NAME sensoric-configuration-service.jar
RUN mkdir -p /usr/local/applications \
	&& apk add --update \
		tomcat-native \
	&& rm -rf /var/cache/apk/*
WORKDIR /usr/local/applications
COPY ${JAR_FILE} ${ARTIFACT_NAME}
EXPOSE 38888
ENTRYPOINT java $JAVA_OPTS -jar $ARTIFACT_NAME \
    --encrypt.key-store.password="$(cat $KEYSTORE_PASSWORD_FILE)" \
    --encrypt.key-store.secret="$(cat $KEYSTORE_SECRET_FILE)" \
    $@
