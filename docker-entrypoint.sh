#!/usr/bin/env bash

set -e

file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

file_env 'KEYSTORE_PASSWORD'
if [ -z "$KEYSTORE_PASSWORD" ]; then
    echo >&2 '  You need to specify KEYSTORE_PASSWORD'
    exit 1
else
    set -- "--encrypt.key-store.password=$KEYSTORE_PASSWORD" "$@"
fi

file_env 'KEYSTORE_SECRET'
if [ -z "$KEYSTORE_SECRET" ]; then
    echo >&2 '  You need to specify KEYSTORE_SECRET'
    exit 1
else
    set -- "--encrypt.key-store.secret=$KEYSTORE_SECRET" "$@"
fi

set -- java $JAVA_OPTS -jar $ARTIFACT_NAME "$@"

exec "$@"
