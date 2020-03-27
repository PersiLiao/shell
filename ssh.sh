#!/bin/bash

#Author: PersiLiao(xiangchu.liao@gmail.com)
#Description: SSH public key generation script automatically
#Version: 1.0
#ssh-keygen -t rsa
#yum install -y openssh-server openssh-clients

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

workDirectory=$(dirname "$0")
pushd ${workDirectory} > /dev/null
workDirectory=$(pwd)

. ./include/color.sh
. ./include/constant.sh

isRootLogin=0
if [ $(id -u) == '0' ]; then
    isRootLogin=1
fi

if [ `uname` == "Darwin" ]; then
    chattrAddCommand="chflags uchg"
    chattrDelCommand="chflags nouchg"
else
    if [ $isRootLogin == 0 ]; then
        chattrAddCommand="sudo chattr +i"
        chattrDelCommand="sudo chattr -i"
    else
        chattrAddCommand="chattr +i"
        chattrDelCommand="chattr -i"
    fi
fi

printf "
#######################################################################
#       SSH public key generation script automatically                #
#       Supported: CentOS/RedHat 6+ Debian 7+ Ubuntu 12+ and macOs    #
#       For more information please visit                             #
#           https://github.com/persiliao/vivian                       #
#######################################################################
${SLF}"
test -d ~/.ssh || mkdir ~/.ssh
chmod 0700 ~/.ssh
test -f ~/.ssh/authorized_keys || touch ~/.ssh/authorized_keys
`$chattrDelCommand ~/.ssh/authorized_keys`
chmod 0600 ~/.ssh/authorized_keys
publicKeyPath="${workDirectory}/public.key"
if [ ! -f $publicKeyPath ]; then
    echo -e "${CFAILURE}Please check that the public.key file exists in the directory !${CEND}${SLF}"
    exit 1
fi
cat $publicKeyPath > ~/.ssh/authorized_keys
writePublicKeyStatus=$?
if [ $writePublicKeyStatus != 0 ]; then
    echo -e "${CFAILURE}SSH public key auto write authorized_keys unsuccessful !${CEND}${SLF}"
    exit 1
else
    echo -e "${CSUCCESS}SSH public key auto write authorized_keys successful. ${CEND}${SLF}"
fi
read -e -p "Whether i need to set up ~/.ssh/authorized_keys not allowed to be modified ? [y/n] :" sshChattrSet
if [ "${sshChattrSet}" == 'y' ]; then
    if [ $(id -u) == '0' ]; then
        `$chattrAddCommand ~/.ssh/authorized_keys`
    else
        `sudo $chattrAddCommand ~/.ssh/authorized_keys`
    fi
    if [ $? == 0 ]; then
        echo -e "${SLF}${CSUCCESS}The setting of the .ssh/authorized_keys does not allow the modification of the successful. ${CEND}${SLF}"
    else
        echo -e "${SLF}${CFAILURE}The setting of the .ssh/authorized_keys does not allow the modification of the  unsuccessful !${CEND}${SLF}"
        exit 1
    fi
fi

exit 0



