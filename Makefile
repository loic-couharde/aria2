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

help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m## /[33m/'
.PHONY: help
