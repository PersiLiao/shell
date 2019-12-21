#!/bin/bash

#Author: PersiLiao(xiangchu.liao@gmail.com)
#Description: Make you more friendly to create user accounts
#Version: 1.0

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

workDirectory=$(dirname "$0")
pushd ${workDirectory} > /dev/null
workDirectory=$(pwd)

. ./include/color.sh
. ./include/constant.sh
. ./include/functions.sh

printf "
#######################################################################
#       Make you more friendly to create user accounts                #
#       Supported: CentOS/RedHat 6+ Debian 7+ and Ubuntu 12+          #
#       For more information please visit                             #
#           https://github.com/PersiLiao/shell                        #
#######################################################################
${SLF}"

[ $(uname) != "Linux" ] && { echo "${CFAILURE}Error: Only support for running under Linux systems !${CEND}"; exit 1; }

if [ $(id -u) != 0 ]; then
    printf "${CFAILURE}Error: You must be root to run this script${CEND}${SLF}"; 
    exit 1;
fi

[ $(id -u) != '0' ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }


InputUsername(){
    while :;do
        read -e -p "Please enter the username: " UserName
        UserNameLenght=${#UserName}
        if [ $UserNameLenght -le 2 ]; then
            echo "${CFAILURE}The username is too short and requires a minimum of three digits !${CEND}"
        else
            checkUsernameExist $UserName
            if [ $? -gt 0 ]; then
                echo "${CFAILURE}The username already in use !${CEND}"
            else
                printf "${SLF}"
                break
            fi
        fi
    done
}

InputUserGroup(){
    read -e -p "Create a group with the same name as the user and set it as the default group [-n] (default: y) ? [y/n]: " DontCreateGroupFlag
    if [ -z "${DontCreateGroupFlag}" ] || [ $DontCreateGroupFlag == 'y' ]; then
        DontCreateGroupArg=""
        DontCreateGroupFlag='y'
    else
        DontCreateGroupArg="-n"
        DontCreateGroupFlag='n'
        printf "${SLF}"
    fi
    if [ $DontCreateGroupFlag == 'n' ]; then
        while :;do
            read -e -p "Set the group name or number of the user's initial login group. [-g] (default: none): " UserGroup
            if [ -z "${UserGroup}" ]; then
                echo "${CFAILURE}The group name or number must exist !${CEND}"
            else
                checkUserGroupExist $UserGroup
                if [ $? == 0 ]; then
                    echo "${CFAILURE}The group name or number must exist !${CEND}"
                else
                    UserGroupArg="-g ${UserGroup}"
                    printf "${SLF}"
                    break
                fi
            fi
        done
    fi
}

InputSupplementaryGroup(){
    read -e -p "Set the supplementary groups name of the user's initial login group. [-G] (default: none): " UserSupplementaryGroup
    if [ -z "${UserSupplementaryGroup}" ]; then
        UserSupplementaryGroupArg=""
    else
        UserSupplementaryGroupArg=$UserSupplementaryGroup
    fi
    printf "${SLF}"
}

InputCreateUserHome(){
    read -e -p "Create the user's home directory [-m] (default: y) ? [y/n]: " DontCreateHomeFlag
    if [ -z "${DontCreateHomeFlag}" ] || [ $DontCreateHomeFlag == 'y' ]; then
        CreateHomeArg="-m"
    else
        CreateHomeArg="-M"
    fi
    printf "${SLF}"
}

InputUserComment(){
    read -e -p "Set the User Comment, Any text string. It is generally a short description of the login [-c] (default: none): " UserComment
    if [ -z "${UserComment}" ]; then
        UserCommentArg=""
    else
        UserCommentArg="-c \"${UserComment}\""
    fi
    printf "${SLF}"
}

InputUserShell(){
    UserShellArg=""
    if [ $UserModeFlag == 1 ]; then
        read -e -p "Set the user shell of the user's initial login [-s] (default: /bin/bash): " UserShell
        if [ ! -z "${UserShell}" ]; then
            UserShellArg="-s ${UserShell}"
        fi
    fi
    if [ $UserModeFlag == 2 ]; then
        UserShellArg="-s /sbin/nologin"
    fi
    printf "${SLF}"
}

InputUserPassword(){
    read -e -p "Create the user's password (default: y) ? [y/n]: " CreatePasswordFlag
    if [ -z "${CreatePasswordFlag}" ] || [ $CreatePasswordFlag == 'y' ]; then
        sudo /usr/bin/passwd $UserName
    fi
    printf "${SLF}"
}

ExecCommand(){
    sudo /sbin/useradd $DontCreateGroupArg $CreateHomeArg $UserGroupArg $UserSupplementaryGroupArg $UserCommentArg $UserShellArg $UserName
    if [ $? == 0 ]; then
        InputUserPassword
    fi
}

while :;do
    printf "What Are You Doing ?
\t${CMSG}1${CEND}. Create a regular user
\t${CMSG}2${CEND}. Create a server daemon user account does not allow it to log in
\t${CMSG}3${CEND}. Create a nginx server daemon user account [www:www]
\t${CMSG}q${CEND}. Exit
${SLF}"
    read -e -p "Please input the correct option: " UserModeFlag
    if [[ ! "${UserModeFlag}" =~ ^[1-3,q]$ ]]; then
        echo "${CFAILURE}input error! Please only input 1~2 and q${CEND}"
    else
        case $UserModeFlag in
        'q')
            exit 0
            ;;
        '1')
            InputUsername
            InputCreateUserHome
            InputUserGroup
            InputSupplementaryGroup
            InputUserShell
            InputUserComment
            ExecCommand
            printf "${SLF}"
            break
            ;;
        '2')
            InputUsername
            InputCreateUserHome
            InputUserGroup
            InputSupplementaryGroup
            InputUserShell
            InputUserComment
            ExecCommand
            printf "${SLF}"
            break
            ;;
        '3')
            sudo useradd -c "Nginx Server Daemon" -M -r -s /sbin/nologin www
            printf "${SLF}"
            break
            ;;
        esac
    fi
done



