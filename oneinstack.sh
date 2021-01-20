#!/usr/bin/env bash

wget -O ~/oneinstack-full.tar.gz -c http://mirrors.linuxeye.com/oneinstack-full.tar.gz && cd ~ && tar xzf oneinstack-full.tar.gz && ./oneinstack/install.sh --nginx_option 1 --php_option 9 --php_extensions imagick,fileinfo,redis --db_option 2 --dbinstallmethod 1 --dbrootpwd oneinstack --redis
