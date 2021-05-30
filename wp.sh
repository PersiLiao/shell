#!/bin/bash

curl -O ~/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x ~/wp
sudo cp ~/wp /usr/local/bin/wp