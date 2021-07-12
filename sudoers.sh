#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

workDirectory=$(dirname "$0")
pushd ${workDirectory} > /dev/null
workDirectory=$(pwd)

. ./include/color.sh
. ./include/constant.sh

if [ -z $1 ]; then
	echo -e "${CFAILURE}Please fill in the username that needs to be added to sudoers! ${CEND}${SLF}"
	return 1
fi

echo "${1} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

if [ $? == 0 ]; then
	echo -e "${SLF}${CSUCCESS}The current user is successfully added to sudoers. ${CEND}${SLF}"
else
	echo -e "${SLF}${CFAILURE}Failed to add current user to sudoers !${CEND}${SLF}"
fi