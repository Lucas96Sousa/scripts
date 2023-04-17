# POP OS INSTALL 

sudo apt upgrade -y 

# Flatpak modules

sudo apt install flatpak -y

flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.google.AndroidStudio in.srev.guiscrcpy  com.discordapp.Discord io.beekeeperstudio.Studio -y

# Programing modules

sudo apt install gcc build-essentials default-jre default-jdk -y

# GOLANG MODULE INSTALL 
cd Downloads && wget https://go.dev/dl/go1.20.3.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz

export PATH=$PATH:/usr/local/go/bin

# RUST MODULE
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source $HOME/.cargo/env

#NEOVIM MODULE

sudo apt install software-properties-common  -y
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update 
sudo apt install neovim -y
sudo apt install python-dev python-pip python3-dev -y
sudo apt install python3-setuptools -y
sudo easy_install3 pip

# VS CODE MODULE
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt install apt-transport-https -y
sudo apt update
sudo apt install code -y

# GH INSTALL
#
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y



