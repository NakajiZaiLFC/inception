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
	php84-phar \
	php84-ctype \
	wget \
	unzip \
	mariadb-client

RUN sed -i "s|;*memory_limit =.*|memory_limit = 512M|i" /etc/php84/php.ini

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php84/php-fpm.d/www.conf
COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["sh", "/usr/local/bin/script.sh"]
