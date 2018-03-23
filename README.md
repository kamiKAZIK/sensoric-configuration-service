# sensoric-configuration-service

keytool -genkeypair -alias sensoric-configuration-service \
       -keyalg RSA -keysize 4096 -sigalg SHA512withRSA \
       -dname 'CN=Sensoric Configuration Service,OU=Sensoric,O=Sensoric' \
       -keypass ************ -keystore sensoric-configuration-service.jks \
       -storepass ************

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
