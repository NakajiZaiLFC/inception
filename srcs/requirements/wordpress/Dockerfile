FROM alpine:3.23

RUN apk update && apk add --no-cache \
	php84 \
	php84-fpm \
	php84-mysqli \
	php84-json \
	php84-curl \
	php84-dom \
	php84-exif \
	php84-fileinfo \
	php84-mbstring \
	php84-openssl \
	php84-xml \
	php84-zip \
	wget \
	unzip

COPY conf/www.conf /etc/php84/php-fpm.d/www.conf
COPY tools/script.sh /usr/local/bin/script.sh

ENTRYPOINT ["sh", "/usr/local/bin/script.sh"]