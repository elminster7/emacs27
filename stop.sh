#!/bin/sh
sudo pkill -9 nginx_tuve
sudo pkill -9 php-fpm
sudo userdel tuve
sudo rm -rf /home/tuve-streaming
