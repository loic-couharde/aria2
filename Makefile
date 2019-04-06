start:
	docker-compose up -d --force-recreate --build --remove-orphans

stop:
	docker-compose stop

restart: stop start

down:
	docker-compose down --rmi all --volumes --remove-orphans

ps:
	docker-compose ps

logs:
	docker-compose logs -f
