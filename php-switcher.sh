#!/bin/sh

#Author: PersiLiao (xiangchu.liao@gmail.com)
#Description: PHP CLI version switcher
#Version: 1.0

# (版本号 版本安装路径)
PHP_VERSION_PATH=("dev" "~/phpdev")

function CheckFile()
{
    FILE_LIST=($1 $2 $3 $4 $5)
    for FILE in "${FILE_LIST}"; do
        if [ ! -e ${FILE} ]; then
            echo ${FILE}" file does not exist ！\\n"
            exit 1
        fi
        if [ ! -x ${FILE} ]; then
            echo ${FILE}" No running rights ！\\n"
            exit 1
        fi
    done
}

function ReconstructionLink()
{
    rm -rf "/usr/local/bin/php"
    rm -rf "/usr/local/bin/phpize"
    rm -rf "/usr/local/bin/php-config"
    rm -rf "/usr/local/bin/php-fpm"
    rm -rf "/usr/local/bin/phar"
    
    ln -s $1 "/usr/local/bin/php"
    ln -s $2 "/usr/local/bin/phpize"
    ln -s $3 "/usr/local/bin/php-config"
    ln -s $4 "/usr/local/bin/php-fpm"
    ln -s $5 "/usr/local/bin/phar"
    echo "\033[32mPHP version switch is successful.\033[0m"
    echo `/usr/local/bin/php -v`"\\n"
    exit 0
}

PHP_VERSION=$1

if [ ! ${PHP_VERSION} ]; then
    echo "\033[31mPlease enter the PHP version you need to switch !\033[0m\\n"
    echo "Usage:"
    echo "  php-version.sh version_number, example: php-version.sh dev"
    echo "  list of supported php versions: "
    for PHP_PATH in "${!PHP_VERSION_PATH[@]}"; do
        if [ `expr $PHP_PATH % 2` = 0 ]; then
            echo "    \033[32m"${PHP_VERSION_PATH[$PHP_PATH]}"\033[0m"
        fi
    done
    exit 1
fi

PHP_VERSION_EXIST=0

for PHP_PATH in "${!PHP_VERSION_PATH[@]}"; do
    if [ "${PHP_VERSION_PATH[$PHP_PATH]}" = "${PHP_VERSION}" ]; then
        PHP_VERSION_EXIST=1
        PHPBIN_PATH=${PHP_VERSION_PATH[$PHP_PATH+1]}"/bin/php"
        PHPIZE_PATH=${PHP_VERSION_PATH[$PHP_PATH+1]}"/bin/phpize"
        PHPCONFIG_PATH=${PHP_VERSION_PATH[$PHP_PATH+1]}"/bin/php-config"
        PHPFPM_PATH=${PHP_VERSION_PATH[$PHP_PATH+1]}"/sbin/php-fpm"
        PHPPHAR_PATH=${PHP_VERSION_PATH[$PHP_PATH+1]}"/bin/phar"
        CheckFile ${PHPBIN_PATH} ${PHPIZE_PATH} ${PHPCONFIG_PATH} ${PHPFPM_PATH} ${PHPPHAR_PATH}
        ReconstructionLink ${PHPBIN_PATH} ${PHPIZE_PATH} ${PHPCONFIG_PATH} ${PHPFPM_PATH} ${PHPPHAR_PATH}
    fi
done

if [ ! ${PHP_VERSION_EXIST} ]; then
    echo "The PHP ${PHP_VERSION} version you entered does not exist.\\n"
    exit 0
fi
