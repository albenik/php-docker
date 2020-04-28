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
PHP56_FPM_XD_DIR := ./5.6-fpm-dev
PHP56_FPM_XD_TAG := php5.6-fpm-dev:$(GITHUB_SHA)
build-php56-fpm-dev:
	docker build --tag $(PHP56_FPM_XD_TAG) --file $(PHP56_FPM_XD_DIR)/Dockerfile $(PHP56_FPM_XD_DIR)

test-build-php56-fpm-dev: build-php56-fpm-dev
	docker image rm $(PHP56_FPM_TAG)
