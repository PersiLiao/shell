#!/bin/bash

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

workDirectory=$(dirname "$0")
# shellcheck disable=SC2164
pushd ${workDirectory} > /dev/null
workDirectory=$(pwd)

sudo yum install -y curl vim wget curl-devel gcc zlib-devel openssl-devel perl cpio expat-devel gettext-devel openssl zlib curl autoconf tk curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-ExtUtils-MakeMaker package gettext-devel asciidoc xmlto
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.28.0.tar.gz
tar -zxvf git-2.28.0.tar.gz
cd ./git-2.28.0
./configure
make -j 4
make install




