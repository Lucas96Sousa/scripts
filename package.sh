#!/usr/bin/env bash
# ARCH INSTALL
arch_install() {
    yes | sudo pacman -Syu
    yes | sudo pacman -Syu base-devel lua gcc clang fish tmux

    # Configuring git
    git config --global user.name "Lucas Sousa"
    git config --global user.email "lucas996oliveira@gmail.com"

    # Install git, go, curl
    yes | sudo pacman -S git go curl

    # Install yay
    git clone https://aur.archlinux.org/yay.git
    cd yay

    yes | makepkg -si

    # Edge, Docker and Vscode
    yes | yay -S docker microsoft-edge-stable visual-studio-code-bin

    #Docker

    sudo usermod -aG docker $USER
    sudo systemctl start docker
    sudo systemctl enable docker

    # Programing modules

    # RUST MODULE
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    source $HOME/.cargo/env

    # GH
    yay github-cli

    #1
    curl -sSO https://downloads.1password.com/linux/tar/stable/x86_64/1password-latest.tar.gz
    sudo tar -xf 1password-latest.tar.gz
    sudo mkdir -p /opt/1Password
    sudo mv 1password-*/* /opt/1Password
    sudo /opt/1Password/after-install.sh

    # Java
    yes | sudo pacman -S jdk17-openjdk

    # NPM
    yes | sudo pacman -Syu npm nodejs

    mkdir ~/.npm-global
    npm config set prefix '~/.npm-global'

    export PATH=~/.npm-global/bin:$PATH

    source ~/.profile

    # PYTHON
    yes | sudo pacman -Syu python3 python-pip

    #flatpak
    sudo pacman -Syu flatpak
    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    flatpak install flathub com.discordapp.Discord io.beekeeperstudio.Studio io.dbeaver.DBeaverCommunity com.github.sdv43.whaler

    #TPM and HOMEBREW(FISH)
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Deb BASES INSTALL
deb_install() {

    # Configuring git
    git config --global user.name "Lucas Sousa"
    git config --global user.email "lucas996oliveira@gmail.com"

    sudo apt install gcc build-essential openjdk-17-jdk openjdk-17-jre fish tmux gettext  wget curl -y

    sudo apt upgrade -y

    # Flatpak modules

    sudo apt install flatpak -y

    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    flatpak install flathub com.discordapp.Discord io.beekeeperstudio.Studio io.dbeaver.DBeaverCommunity com.github.sdv43.whaler -y

    # Programing modules

    # GOLANG MODULE INSTALL
    wget https://go.dev/dl/go1.21.4.linux-amd64.tar.gz
    rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.4.linux-amd64.tar.gz

    export PATH=$PATH:/usr/local/go/bin

    # RUST MODULE
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    source $HOME/.cargo/env

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
    #sudo apt install code -y

    # GH INSTALL

    type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
        sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
        sudo apt update &&
        sudo apt install gh -y
	

    #TPM and HOMEBREW(FISH)
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

Fedora_Install(){
    sudo dnf update && sudo dnf upgrade -y

    #Programing
    #Java
    sudo dnf install java-17-openjdk java-17-openjdk-devel 

    #Nodejs
    sudo dnf module install nodejs:18/common    

    #Cpp
    sudo dnf install cmake g++ make
}

# WSL_INSTALL
Wsl_Debian_install() {
    sudo apt upgrade -y


    # Configuring git
    git config --global user.name "Lucas Sousa"
    git config --global user.email "lucas996oliveira@gmail.com"

    # Programing modules

    sudo apt install curl gcc build-essential openjdk-17-jdk openjdk-17-jre -y

    # GOLANG MODULE INSTALL
    wget https://go.dev/dl/go1.20.3.linux-amd64.tar.gz
    rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz

    export PATH=$PATH:/usr/local/go/bin

    # RUST MODULE
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    source $HOME/.cargo/env

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

    # GH INSTALL

    type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
        sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
        sudo apt update &&
        sudo apt install gh -y
	

    #TPM and HOMEBREW(FISH)
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}
	
#Wsl ARCH
Wsl_Arch_install() {

    yes | sudo pacman -Syu base-devel gcc tmux fish 

     # Configuring git
    git config --global user.name "Lucas Sousa"
    git config --global user.email "lucas996oliveira@gmail.com"

    # Install git, go, curl
    yes | sudo pacman -S go curl

    # Install yay
    git clone https://aur.archlinux.org/yay.git
    cd yay

    yes | makepkg -si

    # BRAVE AND DOCKER
    yes | yay -S docker

    #Docker

    sudo usermod -aG docker $USER
    sudo systemctl start docker
    sudo systemctl enable docker

    # Programing modules

    # RUST MODULE
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    source $HOME/.cargo/env

    # GH
    yay github-cli

    # Java
    yes | sudo pacman -S jdk17-openjdk

    # NPM
    yes | sudo pacman -Syu npm nodejs

    mkdir ~/.npm-global
    npm config set prefix '~/.npm-global'

    export PATH=~/.npm-global/bin:$PATH

    source ~/.profile

    # PYTHON
    yes | sudo pacman -Syu python3 python-pip

    
    #TPM and HOMEBREW(FISH)
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

#Main Menu

while true; do
    clear
    echo "Packages for distros"
    echo "--------------------"
    echo "1. Arch Linux"
    echo "2. Debian bases"
    echo "3. Fedora" 
    echo "4. Wsl_Debian_install"
    echo "5. Wsl_Arch_install"
    echo "6. exit"

    read -p "Enter number " choice

    case $choice in
    1) arch_install ;;
    2) deb_install ;;
    4) Wsl_Debian_install ;;
    5) Wsl_Arch_install ;;
    6) exit ;;
    esac

    read -p "Press enter to continue...."
done
