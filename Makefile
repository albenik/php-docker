GITHUB_SHA ?= local

.DEFAULT: usage

.PHONY: usage
usage:
	@echo "Check targets in Makefile"

.PHONY: build-php56-fpm test-build-php56-fpm
PHP56_FPM_DIR := ./5.6-fpm
PHP56_FPM_TAG := php5.6-fpm:$(GITHUB_SHA)
build-php56-fpm:
	docker build --tag $(PHP56_FPM_TAG) --file $(PHP56_FPM_DIR)/Dockerfile $(PHP56_FPM_DIR)

test-build-php56-fpm: build-php56-fpm
	docker image rm $(PHP56_FPM_TAG)


.PHONY: build-php56-fpm-dev test-build-php56-fpm-dev
PHP56_FPM_DEV_DIR := ./5.6-fpm-dev
PHP56_FPM_DEV_TAG := php5.6-fpm-dev:$(GITHUB_SHA)
build-php56-fpm-dev:
	docker build --tag $(PHP56_FPM_DEV_TAG) --file $(PHP56_FPM_DEV_DIR)/Dockerfile $(PHP56_FPM_DEV_DIR)

test-build-php56-fpm-dev: build-php56-fpm-dev
	docker image rm $(PHP56_FPM_DEV_TAG)

# PHP-7.4-FPM + NGINX for local development
.PHONY: php74-build php74-testbuild php74-clean

PHP74_DEV_DIR := ./7.4-dev
PHP74_DEV_TAG := php7.4-dev:$(GITHUB_SHA)

php74-build:
	docker build --tag $(PHP74_DEV_TAG) --file $(PHP74_DEV_DIR)/Dockerfile $(PHP74_DEV_DIR)

php74-testbuild: php74-build
	docker image rm $(PHP74_DEV_TAG)

php74-clean:
	docker image rm $(PHP74_DEV_TAG)