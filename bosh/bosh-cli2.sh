# dbecfd1973bbc4129c3c8f87900e89fa23023216
SHORT_SHA="sha23216"
MAC_PLATFORM="darwin-amd64"
WIN_PLATFORM="windows-amd64.exe"
LINUX_PLATFORM="linux-amd64"
VERSION="2.0.45"
CLI2_FILENAME="bosh-cli-$VERSION-$PLATFORM-$SHORT_SHA"

THIS_PLATFORM=$(uname)
if [ $(echo $THIS_PLATFORM) == "Darwin" ]; then

   FILE_URL="https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-$VERSION-$MAC_PLATFORM"
   echo $FILE_URL
   curl -fSL -o $CLI2_FILENAME $FILE_URL

   echo "Making bosh executable"
   chmod 755 ./$CLI2_FILENAME
   echo "Moving bosh-cli $VERSION to /usr/local/bin"
   sudo mv ./$CLI2_FILENAME /usr/local/bin/bosh

   echo "Checking bosh version"
   bosh -v
fi
