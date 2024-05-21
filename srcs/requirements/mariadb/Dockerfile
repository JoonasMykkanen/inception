FROM alpine:3.18

RUN apk update && \
	apk add --no-cache \
	mariadb \
	mariadb-client

EXPOSE 3306

COPY conf/mariadb.cnf /etc/my.cnf.d/mariadb.cnf
RUN chmod 644 /etc/my.cnf.d/mariadb.cnf

COPY ./tools/mariadb_setup.sh /tmp/mariadb_setup.sh
RUN chmod +x /tmp/mariadb_setup.sh

CMD ["sh", "/tmp/mariadb_setup.sh"]