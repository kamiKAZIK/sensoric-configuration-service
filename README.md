# sensoric-configuration-service

Sensoric Configuration Service is a small configuration profider based on Spring Cloud Config.
For production deployments encryption must be used in order to protect sensitive configuration values.

keytool -genkeypair -alias sensoric-configuration-service \
       -keyalg RSA -keysize 4096 -sigalg SHA512withRSA \
       -dname 'CN=Sensoric Configuration Service,OU=Sensoric,O=Sensoric' \
       -keypass '************' -keystore sensoric-configuration-service.jks \
       -storepass '************'

docker run --name sensoric-configuration-service -p38888:38888 \
    -v$HOME/git/kami/sensoric/encrypt:/usr/local/applications/encrypt \
    -it -d com.sensoric/sensoric-configuration-service \
    --spring.profiles.active=production \
    --encrypt.key-store.location=file:///usr/local/applications/encrypt/sensoric-configuration-service.jks \
    --encrypt.key-store.alias=sensoric-configuration-service \
    --encrypt.key-store.password=************ \
    --encrypt.key-store.secret=************ \
    --sensoric.security.user.password={noop|bcrypt}************ \
    --sensoric.security.manager.password={noop|bcrypt}************

docker service create \
--replicas 1 \
--name sensoric-configuration-service \
--env KEYSTORE_PASSWORD_FILE=/run/secrets/sensoric-configuration-service-keystore-password \
--env KEYSTORE_SECRET_FILE=/run/secrets/sensoric-configuration-service-keystore-secret \
--env JAVA_OPTS=-Xmx256m \
--limit-cpu 1 \
--limit-memory 512mb \
--publish 38888:38888 \
--network sensoric \
--secret sensoric-configuration-service.jks \
--secret sensoric-configuration-service-keystore-password \
--secret sensoric-configuration-service-keystore-secret \
com.sensoric/sensoric-configuration-service:latest \
--spring.profiles.active=production \
--encrypt.key-store.location=file:///run/secrets/sensoric-configuration-service.jks \
 --encrypt.key-store.alias=sensoric-configuration-service \
--sensoric.security.user.password={bcrypt}$2a$10$3ifR5DRD6d.YZUOm9PtOUeQsJBLU6v7l7.OWdw3oJomc/9tneoUnW \
--sensoric.security.manager.password={bcrypt}$2a$10$CsWcA.B3Xq19hLrJ14R97.b7FA99pE9vKvCt0TwJq.fc7OQtezbwO