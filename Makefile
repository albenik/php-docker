GITHUB_SHA ?= local

.DEFAULT: usage

.PHONY: usage
usage:
	@echo "Check targets in Makefile"

.PHONY: build-php56-fpm test-build-php56-fpm
build-php56-fpm:
	docker build --tag php5.6-fpm:$(GITHUB_SHA) --file ./5.6-fpm/Dockerfile ./5.6-fpm

test-build-php56-fpm: build-php56-fpm
	docker image rm php5.6-fpm:$(GITHUB_SHA)