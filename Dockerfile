FROM openjdk:jre-alpine

ARG JAR_FILE

ENV ARTIFACT_NAME sensoric-configuration-service.jar

RUN mkdir -p /usr/local/applications \
	&& apk add --update \
		tomcat-native \
		bash \
	&& rm -rf /var/cache/apk/*

WORKDIR /usr/local/applications

COPY ${JAR_FILE} ${ARTIFACT_NAME}
COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 38888
