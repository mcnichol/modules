#!/usr/bin/env bash

#export CONCOURSE_EXTERNAL_URL=http://$(ifconfig enp5s0f2 | grep -Eo 'inet ([0-9]*\.){3}[0-9]*' | cut -d ' ' -f 2):8080
export CONCOURSE_EXTERNAL_URL=http://$(ifconfig | grep en0 -A 5 | grep -i "inet " | awk '{print $2}'):8080
echo "Setting CONCOURSE_EXTERNAL_URL to $CONCOURSE_EXTERNAL_URL" 

ORIGIN_DIR="$(pwd)"
SCRIPT_DIR="$(dirname $0)"

FULL_PATH="$ORIGIN_DIR/$SCRIPT_DIR"

mkdir -p keys/web keys/worker

ssh-keygen -t rsa -f ./keys/web/tsa_host_key -N ''
ssh-keygen -t rsa -f ./keys/web/session_signing_key -N ''

ssh-keygen -t rsa -f ./keys/worker/worker_key -N ''

cp ./keys/worker/worker_key.pub ./keys/web/authorized_worker_keys
cp ./keys/web/tsa_host_key.pub ./keys/worker

cd $FULL_PATH

echo "Running \`docker-compose up\` on $(pwd)/docker-compose.yml" 
sleep 1s

docker-compose up -d

if [ -f /usr/local/bin/fly ]; then
    echo "Fly exists, do nothing"
else
    URL="$CONCOURSE_EXTERNAL_URL/api/v1/cli?arch=amd64&platform=linux"
    mkdir tmp
    curl -o tmp/fly $URL
    sudo install tmp/fly /usr/local/bin
    rm -rf tmp
fi

