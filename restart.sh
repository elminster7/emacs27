#!/bin/sh
pkill -9 nginx
pkill -9 php

$PWD/nginx/sbin/nginx_tuve
$PWD/php/sbin/php-fpm
