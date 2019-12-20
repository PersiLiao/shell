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
#       SSH-KEY for CentOS/RedHat 6+ Debian 7+ and Ubuntu 12+         #
#       For more information please visit https://www.sixsir.com      #
#######################################################################
"

cd ~
test -d .ssh || mkdir .ssh
chmod 0700 .ssh
cat > .ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDG6wzFV8qaUIBPewXNjjf2iFLOeWjPKdcKUn4RlmgJ+zKpD3lJVxti4fk+OhL1PMb111u/yc1Idz8ZVnrSMXywrO8t02HdI/c3zlggTjrcfT4s4xgMHAr3p9zpL7yJc/reykLqhKqsGUX/H6SB+VdmoA8WkTreX28H4Aj4BysAeIxxV160RseTJkIx6tWbE18xoG4Lz/qEQikuBRjAK6bBxid12MjoN6xWSjB6gDdkrDwGQuletXuE2EYLY//jHJ7uafjFrKBW4jWr/Ne4QbyvMWBUF/vbTNHPqL9BSSaAVgkPtrazhH15nOaEM28+EyyDzMaECVFE7/oTah86VFY/ persi@Persi.local
EOF

chmod 0600 .ssh/authorized_keys

printf "
SSH public key auto write authorized_keys successful
"



