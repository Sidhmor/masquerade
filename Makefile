ENV	:= $(PWD)/.env
include $(ENV)

up:
	docker-compose build
	docker-compose up -d
	docker-compose run --rm php composer install
down:
	docker-compose down --volumes
bash:
	docker-compose run --rm php bash

bash-database:
	docker-compose run --rm database bash

drop-database-mysql:
	@echo 'Dropping database...'
	docker-compose run --rm php mysql -h database -u root -p$(MYSQL_ROOT_PASSWORD) -e "DROP DATABASE IF EXISTS $(database);"

create-database-mysql:
	@echo 'Creating database...'
	docker-compose run --rm php mysql -h database -u root -p$(MYSQL_ROOT_PASSWORD) -e "CREATE DATABASE $(database);"

import-mysql:
	@echo 'Importing...'
	make drop-database-mysql
	make create-database-mysql
	docker-compose run --rm -T php mysql -h database -u root -p$(MYSQL_ROOT_PASSWORD) $(database) < ./data/$(sqlfile)

anonymize-mysql:
	@echo 'Anonymizing...'
	docker-compose run --rm php php bin/masquerade run --database=$(database) --host=database --username=root --password=$(MYSQL_ROOT_PASSWORD) --platform=$(platform)

dump-mysql:
	@echo 'Dumping...'
	rm -f ./data/anonymized_$(sqlfile)
	docker-compose run --rm php mysqldump -h database -u root -p$(MYSQL_ROOT_PASSWORD) $(database) > ./data/anonymized_$(sqlfile)

anonymize-file-mysql:
	@echo 'Anonymizing file...'
	make import-mysql
	make anonymize-mysql
	make dump-mysql