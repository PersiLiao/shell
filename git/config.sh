#!/bin/sh

#Author: PersiLiao(xiangchu.liao@gmail.com)
#Home: https://www.sixsir.com
#Description: Git
#Version: 1.0

git config --system pull.ff only
git config --system push.default simple
git config --system pull.rebase true
git config --system core.fileMode false