#!/bin/bash

echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

if [ $? == 0 ]; then
	echo -e "${SLF}${CSUCCESS}The current user is successfully added to sudoers. ${CEND}${SLF}"
else
	echo -e "${SLF}${CFAILURE}Failed to add current user to sudoers !${CEND}${SLF}"
	exit 1
fi