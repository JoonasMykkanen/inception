all:
	@if ! grep -q "jmykkane.42.fr" /etc/hosts; then \
		echo "127.0.0.1 jmykkane.42.fr" >> /etc/hosts; \
	fi
	@if ! grep -q "www.jmykkane.42.fr" /etc/hosts; then \
		echo "127.0.0.1 www.jmykkane.42.fr" >> /etc/hosts; \
	fi
	@mkdir -p /Users/joonasmykkanen/data/mariadb-data
	@mkdir -p /Users/joonasmykkanen/data/wordpress-data
	docker-compose -f srcs/docker-compose.yml up --build
	
clean:
	docker-compose -f srcs/docker-compose.yml down --rmi all -v

fclean: clean
	rm -rf /Users/joonasmykkanen/data/mariadb-data
	rm -rf /Users/joonasmykkanen/data/wordpress-data
	docker system prune -f

re: fclean all

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

.PHONY: all clean fclean re up down