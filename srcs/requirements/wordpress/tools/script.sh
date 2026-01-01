#!/bin/sh

if [ ! -f "/var/www/html/wp-config.php" ]; then
	echo "Downloading WordPress"
	rm -rf /var/www/html/*
	cd /var/www/html
	wget https://wordpress.org/wordpress-6.9.tar.gz
	tar -xzf wordpress-6.9.tar.gz
	mv wordpress/* .
	rm -rf wordpress
	rm wordpress-6.9.tar.gz
	chown -R nobody:nobody /var/www/html
fi
echo "Starting PHP-FPM 8.4"

exec /usr/sbin/php-fpm84 -F