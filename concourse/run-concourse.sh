export CONCOURSE_EXTERNAL_URL=http://$(ifconfig enp5s0f2 | grep -Eo 'inet ([0-9]*\.){3}[0-9]*' | cut -d ' ' -f 2):8080
echo "Setting CONCOURSE_EXTERNAL_URL to $CONCOURSE_EXTERNAL_URL" 

cd ~/workspace/modules/concourse
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

