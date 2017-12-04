#!/usr/bin/env bash

SCRIPT_DIR=${BASH_SOURCE%/*}
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

# Setup Director VM

git clone https://github.com/cloudfoundry/bosh-deployment $SCRIPT_DIR/bosh-deployment
mkdir -p $SCRIPT_DIR/deployments/vbox
cd $SCRIPT_DIR/deployments/vbox

bosh create-env ../../bosh-deployment/bosh.yml \
  --state ./state.json \
  -o ../../bosh-deployment/virtualbox/cpi.yml \
  -o ../../bosh-deployment/virtualbox/outbound-network.yml \
  -o ../../bosh-deployment/bosh-lite.yml \
  -o ../../bosh-deployment/bosh-lite-runc.yml \
  -o ../../bosh-deployment/jumpbox-user.yml \
  --vars-store ./creds.yml \
  -v director_name="Bosh Lite Director" \
  -v internal_ip=192.168.50.6 \
  -v internal_gw=192.168.50.1 \
  -v internal_cidr=192.168.50.0/24 \
  -v outbound_network_name=NatNetwork

bosh alias-env vbox -e 192.168.50.6 --ca-cert <(bosh int ./creds.yml --path /director_ssl/ca)
export BOSH_CLIENT=admin
export BOSH_CLIENT_SECRET=`bosh int ./creds.yml --path /admin_password`

bosh -e vbox env
