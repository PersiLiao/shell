#!/bin/bash

curl -O ~/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x ~/wp
sudo mv ~/wp /usr/local/bin/wp

if [ $? == 0 ]; then
	echo -e "${SLF}${CSUCCESS}wp cli installed successfully. ${CEND}${SLF}"
else
	echo -e "${SLF}${CFAILURE}wp cli installed unsuccessfully !${CEND}${SLF}"
	exit 1
fi