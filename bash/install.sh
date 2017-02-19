printf "\n\
#####################\n\
# Bash Module Setup #\n\
#####################\n\
"

sudo apt-get -y install bash
chsh -s $(which bash) $(whoami)

echo "Restart Shell Session to see new effects"
