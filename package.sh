#!/usr/bin/env bash
# Deb BASES INSTALL  
    sudo apt install gcc build-essential podman python3-pip golang-go gettext  wget curl -y

    sudo apt upgrade -y

    # Flatpak modules

    sudo apt install flatpak -y

    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    # Programing modules

    # RUST MODULE
    
    #curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    #source $HOME/.cargo/env

    #NPM
    sudo apt-get install -y ca-certificates curl gnupg
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    NODE_MAJOR=20
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    sudo apt-get install -y nodejs

    mkdir ~/.npm-global
    npm config set prefix '~/.npm-global'

    export PATH=~/.npm-global/bin:$PATH

    source ~/.profile

    # VS CODE MODULE
    sudo apt-get install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg

    sudo apt install apt-transport-https -y
    sudo apt update
    sudo apt install code -y

echo "Instalação finalizada"


