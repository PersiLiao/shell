#!/bin/bash


export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

workDirectory=$(dirname "$0")
pushd ${workDirectory} > /dev/null
workDirectory=$(pwd)

. ./include/color.sh
. ./include/constant.sh

sudo groupadd docker
sudo gpasswd -a $USER docker
sudo newgrp - docker
sudo systemctl restart docker

echo '{"registry-mirrors": ["https://ustc-edu-cn.mirror.aliyuncs.com/"]}' > /etc/docker/daemon.json

if [ $? == 0 ]; then
	echo -e "${SLF}${CSUCCESS}docker setting successful. ${CEND}${SLF}"
else
	echo -e "${SLF}${CFAILURE}docker setting successful unsuccessful !${CEND}${SLF}"
	exit 1
fi
