#!/usr/bin/env bash

source "../_common_scripts/config/styles.sh"
source "../_common_scripts/config/functions.sh"

SHORT_SHA="sha23216"
MAC_PLATFORM="darwin-amd64"
WIN_PLATFORM="windows-amd64.exe"
LINUX_PLATFORM="linux-amd64"
VERSION="2.0.45"
CLI2_FILENAME="bosh-cli-$VERSION-$PLATFORM-$SHORT_SHA"

THIS_PLATFORM=$(uname)
if [ $(echo $THIS_PLATFORM) == "Darwin" ]; then

   FILE_URL="https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-$VERSION-$MAC_PLATFORM"
   curl -fSL -o $CLI2_FILENAME $FILE_URL --progress-bar

   msgWithColor "Making bosh executable" $GREEN
   chmod 755 ./$CLI2_FILENAME
   msgWithColor "...done\n" $GREEN

   msgWithColor "Moving bosh-cli $VERSION to /usr/local/bin" $GREEN
   sudo mv ./$CLI2_FILENAME /usr/local/bin/bosh
   msgWithColor "...done\n" $GREEN

   msgWithColor "Checking bosh version\n" $GREEN
   bosh -v
fi

source "bosh-cli-dependencies.sh"
