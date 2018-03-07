# sensoric-configuration-service

docker run --name sensoric-configuration-service -p38888:38888 \
    -v$HOME/git/kami/sensoric/encrypt:/usr/local/applications/encrypt \
    -it -d com.sensoric/sensoric-configuration-service \
    --spring.profiles.active=??? \
    --encrypt.key-store.location=??? \
    --encrypt.key-store.password=??? \
    --encrypt.key-store.alias=??? \
    --encrypt.key-store.secret=???
