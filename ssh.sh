#!/bin/bash

#Author: PersiLiao(xiangchu.liao@gmail.com)
#Description: SSH key generation script automatically
#Version: 1.0
#ssh-keygen -t rsa
#yum install -y openssh-server openssh-clients

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
#######################################################################
#       SSH for CentOS/RedHat 6+ Debian 7+ and Ubuntu 12+ macOs       #
#       For more information please visit https://www.sixsir.com      #
#######################################################################

"

cd ~
test -d ~/.ssh || mkdir ~/.ssh
chmod 0700 .ssh
test -f ~/.ssh/authorized_keys || touch ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
publicKeyPath="$(dirname "$0")/public.key"
if [ ! -f $publicKeyPath ]; then
    echo -e "\033[31mPlease check that the public.key file exists in the directory !\033[0m"
    exit 1
fi
cat $publicKeyPath > ~/.ssh/authorized_keys
writePublicKeyStatus=$?
if [ $writePublicKeyStatus != 0 ]; then
    echo -e "\033[31mSSH public key auto write authorized_keys unsuccessful !\033[0m"
    exit 1
fi

read -e -p "Set a block to modify files ? [y/n] " sshChattrSet
if [ "${sshChattrSet}" == 'y' ]; then
    if [ `uname` == "Darwin" ]; then
        chattrCommand="chflags uchg"
    else
        chattrCommand="chattr +i"
    fi
    if [ $(id -u) == '0' ]; then
        `$chattrCommand ~/.ssh/authorized_keys`
    else
        `sudo $chattrCommand ~/.ssh/authorized_keys`
    fi
    if [ $? != 0 ]; then
        echo -e "\033[31mAuthorized_keys permission setting unsuccessful !\033[0m"
        exit 1
    fi
fi
echo -e "\033[32m SSH public key auto write authorized_keys successful. \033[0m"

exit 0



