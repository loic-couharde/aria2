UID = $(shell id -u)
GID = $(shell id -g)
COMPOSE = UID=${UID} GID=${GID} docker-compose

start:
	cp -n .env.dist .env
	${COMPOSE} up -d --force-recreate --build --remove-orphans

stop:
	${COMPOSE} stop

restart: stop start

down:
	${COMPOSE} down --rmi all --volumes --remove-orphans

reset: down start

ps:
	${COMPOSE} ps

logs:
	${COMPOSE} logs -f

sh.aria2:
	${COMPOSE} exec aria2 sh

sh.webui:
	${COMPOSE} exec webui sh
