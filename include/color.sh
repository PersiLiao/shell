#!/bin/bash
#
#Author: PersiLiao(xiangchu.liao@gmail.com)
#Description: Terminal shell color

echo=echo
for cmd in echo /bin/echo; do
  $cmd >/dev/null 2>&1 || continue
  if ! $cmd -e "" | grep -qE '^-e'; then
    echo=$cmd
    break
  fi
done
CBE=$($echo -e "\033[") # Begin echo
CEND="${CBE}0m" # End
CDGREEN="${CBE}32m"
CRED="${CBE}1;31m"
CGREEN="${CBE}1;32m"
CYELLOW="${CBE}1;33m"
CBLUE="${CBE}1;34m"
CMAGENTA="${CBE}1;35m"
CCYAN="${CBE}1;36m"
CSUCCESS="$CDGREEN"
CFAILURE="$CRED"
CQUESTION="$CMAGENTA"
CWARNING="$CYELLOW"
CMSG="$CCYAN"
