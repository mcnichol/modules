printf "\n\
####################\n\
# Git Module Setup #\n\
####################\n\
"

sudo apt-get -y install git \
    tig                         #Git CLI Commit Browser

#My custom configuration values
git config --global user.name "McNichol"
git config --global user.email mcnichol.m@gmail.com
git config --global core.editor "vim"

