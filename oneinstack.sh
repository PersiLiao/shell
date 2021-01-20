#!/usr/bin/env bash

wget -c http://mirrors.linuxeye.com/oneinstack-full.tar.gz && tar xzf oneinstack-full.tar.gz && ./oneinstack/install.sh --nginx_option 1 --php_option 9 --php_extensions imagick,fileinfo,redis --db_option 2 --dbinstallmethod 1 --dbrootpwd oneinstack --redis
