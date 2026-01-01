FROM alpine:3.23

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY conf/50-server.cnf /etc/my.cnf.d/50-server.cnf

COPY tools/script.sh /usr/local/bin/script.sh

ENTRYPOINT ["sh", "/usr/local/bin/script.sh"]