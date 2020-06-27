#!/bin/sh
sudo rm -rf /home/tuve-streaming/
sudo userdel tuve
sudo pkill -9 nginx
sudo pkill -9 php*
sudo pkill -9 ffmpeg
