printf "\n\
####################\n\
# Zsh Module Setup #\n\
####################\n\
"

CHECK_ZSH_INSTALLED=$(grep /zsh$ /etc/shells | wc -l)
if [ ! $CHECK_ZSH_INSTALLED -ge 1 ]; then
    printf "Zsh is not installed"
    sudo apt-get -y install zsh
fi

printf "Changing Default Shell to ZSH\n"
if [ ! -z $DEFAULT_PASSWORD ]; then
    echo $DEFAULT_PASSWORD | chsh -s $(which zsh) > /dev/null 2>&1
else
    chsh -s $(which zsh)
fi 

###################
# oh-my-zsh setup #
###################
#Source: https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
if [ ! -n "$ZSH" ]; then
    ZSH=~/.oh-my-zsh
fi

if [ -d "$ZSH" ]; then
    printf "Oh My Zsh Already Installed\n"
    printf "Remove $ZSH if you want to re-install\n"
else
    git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git $ZSH
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    sed "/^export ZSH=/ c\ ZSH=$ZSH" ~/.zshrc > ~/.zshrc-temp && mv ~/.zshrc-temp ~/.zshrc
fi
