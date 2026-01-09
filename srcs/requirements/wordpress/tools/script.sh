#!/bin/sh

set -e

cd /var/www/html
if [ ! -f "/var/www/html/index.php" ]; then
	echo "Downloading WordPress"
	wp core download --allow-root
fi

echo "Waiting for MariaDB"
while ! mariadb-admin ping -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASS" --silent; do
	sleep 1
done
if [ ! -f "/var/www/html/wp-config.php" ]; then
	wp config create \
		--dbname=$DB_NAME \
		--dbuser=$DB_USER \
		--dbpass=$DB_PASS \
		--dbhost=$DB_HOST \
		--allow-root
	wp core install \
		--url="https://$DOMAIN_NAME" \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASS \
		--admin_email=$WP_ADMIN_EMAIL \
		--allow-root
	wp user create \
		yehara \
		yehara@gmail.com \
		--role=administrator \
		--allow-root

	echo "WordPress setup completed"
fi
echo "Starting PHP-FPM 8.3"
exec /usr/sbin/php-fpm83 -F