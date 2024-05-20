#! /bin/sh

MAX_RETRIES=5
RETRY_INTERVAL=5
attempt=0
check_mariadb() {
    wget --spider -q mariadb:3306
}

while [ $attempt -lt $MAX_RETRIES ]; do
    if check_mariadb; then
        echo "Database connection successful."
        break
    else
        echo "Waiting for database connection..."
        sleep $RETRY_INTERVAL
    fi
    attempt=$((attempt + 1))
done


if [ -f "wp-config.php" ]; then
    echo "WordPress is already installed."
else
	wp core download --allow-root
	wp config create --allow-root \
		--dbhost=$MARIADB_HOST \
		--dbname=$MARIADB_DATABASE \
		--dbuser=$MARIADB_USER \
		--dbpass=$MARIADB_PASSWORD \
		--path=/var/www/html \
		--force
	wp core install --allow-root \
		--url=https://$DOMAIN_NAME \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--path=/var/www/html/
	wp user create \
		$WP_USER \
		$WP_EMAIL \
		--role=author \
		--user_pass=$WP_PASSWORD \
		--allow-root
	wp theme install inspiro --allow-root --activate
	wp plugin update --all --allow-root
	echo "Finished installation and setup!"
fi

exec /usr/sbin/php-fpm7.4 -F
echo "PHP engine runnning"
