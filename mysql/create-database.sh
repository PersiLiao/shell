#!/bin/bash

#Author: PersiLiao(xiangchu.liao@gmail.com)
#Description: MySQL convenient database creation
#Version: 1.0

export PATH=/usr/local/mysql/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

workDirectory=$(dirname "$0")
pushd ${workDirectory} > /dev/null
workDirectory=$(pwd)

. ../include/color.sh
. ../include/constant.sh

printf "
#######################################################################
#       MySQL convenient database creation                            #     
#       Supported: CentOS/RedHat 6+ Debian 7+ Ubuntu 12+ and macOs    #
#       For more information please visit                             #
#           https://github.com/persiliao/vivian                       #
#######################################################################
${SLF}"

while :;do
    read -e -p "Please enter the database name :" databaseName
    if [ ! -n "$databaseName" ]; then
        echo "${CFAILURE}database name must be !${CEND}"
    else
        createDatabaseSql="mysql -e \"CREATE DATABASE IF NOT EXISTS ${databaseName} DEFAULT CHARACTER SET utf8mb4;\""
        # $($createDatabaseSql)
        echo -e "${SLF}${CSUCCESS}${createDatabaseSql}${CEND}${SLF}" 
        if [ $? == 0 ]; then
            # echo -e "${SLF}${CSUCCESS}mysql database create successful. ${CEND}${SLF}"
            break
        else
            echo -e "${SLF}${CFAILURE}mysql database create unsuccessful !${CEND}${SLF}"
        fi
    fi
done

exit 0



