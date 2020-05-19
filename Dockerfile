FROM nginx:1.17.10-alpine
LABEL maintainer="Paul Warren <paul@paulwarren.ca>"

COPY ./default.template /etc/nginx/conf.d/
COPY ./nginx.conf /etc/nginx/
COPY ./errors.template /etc/nginx/conf.d/

ENV LOG_HOST="0"
ENV LOG_PORT="0"
ENV PASS_HOST="app"
ENV PASS_PORT=9000

#RUN set -ex; \
#    if [ "$LOG_HOST" -ne "0" ] && [ "$LOG_PORT" -ne "0" ]; \
#    then \
#        envsubst "$(printf '${%s} ' $(env | sed 's/=.*//'))" < /etc/nginx/conf.d/errors.template > /etc/nginx/conf.d/errors.conf; \
#    fi; \
#    envsubst "$(printf '${%s} ' $(env | sed 's/=.*//'))" < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf;
#    echo $LOG_HOST; \
#    envsubst < /etc/nginx/conf.d/errors.template > /etc/nginx/conf.d/errors.conf2; \
#    envsubst < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf2;

EXPOSE 80

COPY recognizer-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/recognizer-entrypoint.sh / # backwards compat
ENTRYPOINT ["recognizer-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
