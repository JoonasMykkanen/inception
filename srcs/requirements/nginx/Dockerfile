FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade && \
	apt-get -y install openssl ssl-cert nginx && \
	rm -rf /var/lib/apt/lists/*
	
RUN adduser -D -H -s /sbin/nologin -g www-data -G www-data www-data


RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
-out /etc/nginx/ssl/certificate.crt \
-keyout /etc/nginx/ssl/certificate.key \
-subj "/C=FI/ST=HK/L=HK/O=42 School/OU=jmykkane/CN=jmykkane.42.fr"


COPY	conf/nginx.conf		/etc/nginx/

RUN		mkdir -p /var/www/
RUN		chown -R www-data:www-data /var/www/


EXPOSE 443

CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]
