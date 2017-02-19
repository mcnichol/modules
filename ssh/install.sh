sudo apt-get -y install openssh-server

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.default-template
sudo chmod 666 /etc/ssh/sshd_config.default-template

sudo systemctl restart ssh

