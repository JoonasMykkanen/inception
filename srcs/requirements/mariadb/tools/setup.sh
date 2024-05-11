#!/bin/bash

# Create necessary directories and set permissions
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql
mkdir -p /var/log/mysql
chown -R mysql:mysql /var/log/mysql

# Initialize MySQL data directory
mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED by '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';
GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_USER}'@'%';

FLUSH PRIVILEGES;
EOF

# Start MariaDB server with custom configuration file
echo "Starting MariaDB service in the foreground"
exec mysqld "--defaults-file=/etc/mariadb.conf.d/my.cnf"