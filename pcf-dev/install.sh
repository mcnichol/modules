#!/usr/bin/env bash

sudo apt-get -y install unzip virtualbox

curl -fsSL https://github.com/mcnichol/file-sources/blob/master/pcfdev-v0.24.0-linux.zip?raw=true > pcf-dev.zip

rm pcfdev-v*
unzip pcf-dev.zip && rm pcf-dev.zip

./pcfdev-v*

