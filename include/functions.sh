#!/bin/bash
#
#Author: PersiLiao(xiangchu.liao@gmail.com)
#Description: Functions

checkUserIsRoot(){
    if [ $(id -u) == 0 ]; then
        return 1
    else
        return 0
    fi
}

checkUsernameExist() {
    return $(cat /etc/passwd | awk -F: '{print $1}'|grep -E "^$1\$"|wc -l)
}

checkUserGroupExist() {
    return $(cat /etc/group | awk -F: '{print $1}'|grep -E "^$1\$"|wc -l)
}
