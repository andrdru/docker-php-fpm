#!/bin/sh
/etc/init.d/exim4 start;
docker-php-entrypoint php-fpm;
