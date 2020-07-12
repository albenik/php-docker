#!/bin/sh

service ssh start
service nginx start
service --status-all
php-fpm