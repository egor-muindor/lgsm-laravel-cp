APP_CONTAINER=manga-reader-api
MIGRATOR=migrator

build:
	@echo 'Start building dev environment'
	docker-compose build

install: build
	@test -f ./src/.env && echo '.env exists' && exit 1
	@cp ./src/.env.example ./src/.env
	@echo 'Start 1/3 step | Starting container `$(APP_CONTAINER)`'
	@docker-compose up -d $(APP_CONTAINER)
	@echo 'Start 2/3 step | Key generating'
	@docker-compose exec $(APP_CONTAINER) php artisan key:generate
	@echo 'Start 3/3 step | Shutdown container `$(APP_CONTAINER)`'
	@docker-compose down $(APP_CONTAINER)
	@echo 'DONE!'

reload: reload

restart:
	docker-compose restart

attach:
	docker-compose exec $(APP_CONTAINER) /bin/bash

migrate:
	docker-compose up $(MIGRATOR)

run: start

start:
	docker-compose up -d

down: stop

stop:
	docker-compose down

run-dev:
	docker-compose up

analyse:
	cd src && $(MAKE) analyse

style:
	cd src && $(MAKE) style

phpcsfix:
	cd src && $(MAKE) phpcsfix

inithooks:
	git config core.hooksPath githooks
