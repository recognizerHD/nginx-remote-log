#!/usr/bin/env sh
if [ "$LOG_HOST" != "0" ] && [ "$LOG_PORT" != "0" ];
then
    envsubst "$(printf '${%s} ' $(env | sed 's/=.*//'))" < /etc/nginx/conf.d/errors.template > /etc/nginx/conf.d/errors.conf;
else
    cat /etc/nginx/conf.d/errors.template2 > /etc/nginx/conf.d/errors.conf;
fi;
envsubst "$(printf '${%s} ' $(env | sed 's/=.*//'))" < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf;

exec "$@"
