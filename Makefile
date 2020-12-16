SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

GITHUB_SHA ?= local
DBUILD = docker build --progress plain

.PHONY: help

help: ## List all available targets with help
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'

# ------------------------------------------------
# PHP 5.6-fmp
# ------------------------------------------------

.PHONY: build-php56-fpm test-build-php56-fpm

PHP56_FPM_DIR := ./5.6-fpm
PHP56_FPM_TAG := php5.6-fpm:$(GITHUB_SHA)

build-php56-fpm: ## Build PHP 5.6-fpm
	$(DBUILD) --tag $(PHP56_FPM_TAG) --file $(PHP56_FPM_DIR)/Dockerfile $(PHP56_FPM_DIR)

test-build-php56-fpm: build-php56-fpm ## Test build PHP 5.6-fpm
	docker image rm $(PHP56_FPM_TAG)

# ------------------------------------------------
# PHP 5.6-fmp-dev
# ------------------------------------------------

.PHONY: build-php56-fpm-dev test-build-php56-fpm-dev

PHP56_FPM_DEV_DIR := ./5.6-fpm-dev
PHP56_FPM_DEV_TAG := php5.6-fpm-dev:$(GITHUB_SHA)

build-php56-fpm-dev: ## Build PHP 5.6-fpm-dev
	$(DBUILD) --tag $(PHP56_FPM_DEV_TAG) --file $(PHP56_FPM_DEV_DIR)/Dockerfile $(PHP56_FPM_DEV_DIR)

test-build-php56-fpm-dev: build-php56-fpm-dev ## Test build PHP 5.6-fpm-dev
	docker image rm $(PHP56_FPM_DEV_TAG)

# ------------------------------------------------
# PHP 7.4-fpm + NGINX + SSH for local development
# ------------------------------------------------

.PHONY: php74-dev-build php74-dev-testbuild php74-dev-clean

PHP74_DEV_DIR := ./7.4-dev
PHP74_DEV_TAG := php7.4-dev:$(GITHUB_SHA)

php74-dev-build: ## Build PHP 7.4-dev
	$(DBUILD) --tag $(PHP74_DEV_TAG) --file $(PHP74_DEV_DIR)/Dockerfile $(PHP74_DEV_DIR)

php74-dev-testbuild: php74-dev-build ## Test build PHP 7.4-dev
	docker image rm $(PHP74_DEV_TAG)

php74-dev-clean: ## Remove PHP 7.4-dev docker image
	docker image rm $(PHP74_DEV_TAG)