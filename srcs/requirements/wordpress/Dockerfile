FROM debian:bullseye

RUN mkdir -p /run/php && mkdir -p /var/www/html
RUN getent group www-data || addgroup --system www-data
RUN id -u www-data &>/dev/null || adduser --system --ingroup www-data --disabled-password --no-create-home www-data
RUN chown -R www-data:www-data /var/www/html && chmod -R 775 /var/www/html
	
RUN apt-get update && apt-get -y upgrade && apt-get -y install php7.4 php7.4-fpm php7.4-mysqli mariadb-client wget sendmail

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/wp

EXPOSE 9000

CMD [ "setup.sh" ]