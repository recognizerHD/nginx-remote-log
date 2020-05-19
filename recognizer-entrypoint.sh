#!/usr/bin/env sh
if [ "$LOG_HOST" != "0" ] && [ "$LOG_PORT" != "0" ];
then
    envsubst "$(printf '${%s} ' $(env | sed 's/=.*//'))" < /etc/nginx/conf.d/logs.template > /etc/nginx/conf.d/logs.conf;
else
    cat /etc/nginx/conf.d/logs-default.template > /etc/nginx/conf.d/logs.conf;
fi;
envsubst "$(printf '${%s} ' $(env | sed 's/=.*//'))" < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf;

exec "$@"
