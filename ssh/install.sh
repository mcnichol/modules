

#TODO
# Extract as utility for other modules
# use $PACKAGE_TO_INSTALL inside of grep
# Issues:
# Does not account for packages that have been installed and then uninstalled (rc)

RESTART_REQUIRED=false
PACKAGE_TO_INSTALL=openssh-server

PACAKGE_NEVER_INSTALLED="$(dpkg-query -l $PACKAGE_TO_INSTALL > /dev/null 2>&1 | grep -Eo 'no packages found matching openssh-server')"
if [ ! -z $PACAKGE_NEVER_INSTALLED ]; then
    sudo apt-get -y $PACKAGE_TO_INSTALL

    sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.default-template
    sudo chmod 666 /etc/ssh/sshd_config.default-template
    RESTART_REQUIRED=true
else
    printf "Package exists (or was previously installed): $PACKAGE_TO_INSTALL\n"
    printf "Please re-install package manually:\n\n \
    sudo apt-get -y install $PACKAGE_TO_INSTALL \n\n"
fi

DIRECTORY=~/.ssh
if [ ! -d $DIRECTORY ]; then
    printf "Creating ~/.ssh directory"
    mkdir ~/.ssh
    touch ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
else
    printf ".ssh directory exists, skipping local configuration\n\n"
fi

if [ "$RESTART_REQUIRED" = true ]; then
    printf "Restarting SSH service\n"
    sudo systemctl restart ssh
fi
