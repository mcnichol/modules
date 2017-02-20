printf "\n\
####################\n\
# Vim Module Setup #\n\
####################\n\
"

PACKAGE_TO_INSTALL=vim

PACAKGE_NEVER_INSTALLED="$(dpkg-query -l $PACKAGE_TO_INSTALL > /dev/null 2>&1 | grep -Eo 'no packages found matching vim')"
if [ ! -z $PACAKGE_NEVER_INSTALLED ]; then
    sudo apt-get -y $PACKAGE_TO_INSTALL
else
    printf "Package exists (or was previously installed): $PACKAGE_TO_INSTALL\n"
    printf "Please re-install package manually:\n\n \
    sudo apt-get -y install $PACKAGE_TO_INSTALL \n\n"
fi

if [ ! -z "$VIM_CONFIG_URL" ]; then
    printf "Copying vimrc from $VIM_CONFIG_URL\n"
    cp $VIM_CONFIG_URL/vimrc ~/.vimrc
fi

