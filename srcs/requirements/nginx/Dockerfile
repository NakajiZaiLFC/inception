# 用語解説 
# FROMでここから始める。
# RUNはビルド時に実行するコマンド
# CMDはコンテナ起動時に実行されるコマンド（PID1）


FROM alpine:3.22
RUN apk update && apk add --no-cache nginx openssl
RUN mkdir -p /run/nginx/ /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/inception.key \
	-out /etc/nginx/ssl/inception.crt \
	-subj "/C=JP/ST=Tokyo/L=Inception/O=42Tokyo/OU=Student/CN=inception"

COPY conf/nginx.conf /etc/nginx/http.d/default.conf

CMD ["nginx", "-g", "daemon off;"]