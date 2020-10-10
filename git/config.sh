#!/bin/sh

#Author: PersiLiao(xiangchu.liao@gmail.com)
#Home: https://www.sixsir.com
#Description: Git
#Version: 1.0

git config --global pull.ff only
git config --global push.default simple
git config --global pull.rebase true
git config --global core.fileMode false

if [ `uname` == "Darwin" ]; then
    git config --global credential.helper osxkeychain
else
    git config --global credential.helper store
fi