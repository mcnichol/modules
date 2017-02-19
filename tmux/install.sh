printf "\n\
#####################\n\
# tmux Module Setup #\n\
#####################\n\
"

PACKAGE_TO_INSTALL=tmux

PACAKGE_NEVER_INSTALLED="$(dpkg-query -l $PACKAGE_TO_INSTALL > /dev/null 2>&1 | grep -Eo 'no packages found matching tmux')"
if [ ! -z $PACAKGE_NEVER_INSTALLED ]; then
    sudo apt-get -y $PACKAGE_TO_INSTALL
else
    printf "Package exists (or was previously installed): $PACKAGE_TO_INSTALL\n"
    printf "Please re-install package manually:\n\n \
    sudo apt-get -y install $PACKAGE_TO_INSTALL \n\n"
fi

if [ ! -z "$TMUX_CONFIG_URL" ]; then
    printf "Copying tmux.conf from $TMUX_CONFIG_URL\n"
    cp $TMUX_CONFIG_URL/tmux.conf ~/.tmux.conf
fi
