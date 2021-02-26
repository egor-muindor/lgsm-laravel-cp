ROOT_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

PHPSTAN=$(ROOT_DIR)/vendor/bin/phpstan
PHPSTAN_OPTIONS=--memory-limit=1G

PHPCSFIX=$(ROOT_DIR)/vendor/bin/php-cs-fixer
PHPCS_IGNORE=resources/lang,resources/views,bootstrap/cache,database/migrations,bin,config,vendor,public,storage

PHPCBF=$(ROOT_DIR)/vendor/bin/phpcbf

analyse:
	@$(PHPSTAN) analyse $(PHPSTAN_OPTIONS)
	@echo 'PHPSTAN: OK\n'

style:
	@$(PHPCSFIX) fix --dry-run
	@echo 'PHPCS: OK\n'

phpcsfix:
	@$(PHPCSFIX) fix

lint: style analyse
