FROM alpine:3.22

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY conf/50-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY tools/script.sh /usr/local/bin/script.sh

ENTRYPOINT ["sh", "/usr/local/bin/script.sh"]
