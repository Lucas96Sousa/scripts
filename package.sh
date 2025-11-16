#!/usr/bin/env bash
# ARCH INSTALL
Arch_Install() {
    yes | sudo pacman -Syu
    yes | sudo pacman -Syu base-devel lua gcc clang neovim go

   
    # Install git, go, curl
    yes | sudo pacman -S git go curl
 # Install yay
    # Terminal
    filenames=('/usr/bin/zsh', '/usr/bin/tmux', '/bin/yay')
    for filename in ${filenames[@]}; do
        if [ -f $filename ]; then
            echo "$filename exists."
        else
            echo "$filename does not exists need to install"
            yes | sudo pacman -S kitty tmux zsh -y
	    git clone https://aur.archlinux.org/yay.git 
    	    mv yay $HOME/$USER && cd $HOME/$USER/yay
	    yes | makepkg -si
        fi
    done

    # Edge, Docker and Vscode
    yes | yay -S docker docker-compose microsoft-edge-stable visual-studio-code-bin

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
    yes | sudo pacman -S jdk21-openjdk

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

    flatpak install flathub com.discordapp.Discord io.beekeeperstudio.Studio io.dbeaver.DBeaverCommunity -y 
    #TPM and HOMEBREW(FISH)
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
}

# Deb BASES INSTALL
deb_install() {

    

    sudo apt install gcc build-essential podman python3-pip golang-go zsh kitty tmux gettext  wget curl -y

    sudo apt upgrade -y

    # Flatpak modules

    sudo apt install flatpak -y

    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    flatpak install flathub com.discordapp.Discord io.beekeeperstudio.Studio io.dbeaver.DBeaverCommunity -y

    # Programing modules

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

    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
}

Fedora_Install(){
    # Update
    sudo dnf update && sudo dnf upgrade -y

     

    # Terminal
    filenames=('/usr/bin/fish', '/usr/bin/tmux')
    for filename in ${filenames[@]}; do
        if [ -f $filename ]; then
            echo "$filename exists."
        else
            echo "$filename does not exists need to install"
            sudo dnf install kitty tmux fish -y
        fi
    done

    #Programing

	#Docker
 	sudo dnf -y install dnf-plugins-core
  	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

	sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    sudo groupadd docker
    sudo usermod -aG docker $USER

    newgrp docker

 	sudo systemctl start docker 
  	sudo systemctl enable docker
	
    #Java
    sudo dnf install java-17-openjdk java-17-openjdk-devel 

    #Nodejs
    sudo dnf module install nodejs:20/common    

    #Cpp
    sudo dnf install cmake g++ make

    #Elixir
    sudo dnf install erlang elixir 
    #Golang
    sudo dnf install go

    #TPM and HOMEBREW(FISH)
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
}


# WSL_INSTALL
Wsl_Debian_install() {
    sudo apt upgrade -y



    # Programing modules

    sudo apt install gcc build-essential docker.io containerd  tmux gettext  wget curl -y

    sudo usermod -aG docker $USER 

    newgrp docker


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

    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
}
	
#Wsl ARCH
Wsl_Arch_install() {

    yes | sudo pacman -Syu base-devel gcc

     

    # Install git, go, curl
    yes | sudo pacman -S go curl

    # Install yay
    # Terminal
    filenames=('/usr/bin/zsh', '/usr/bin/tmux', '/bin/yay')
    for filename in ${filenames[@]}; do
        if [ -f $filename ]; then
            echo "$filename exists."
        else
            echo "$filename does not exists need to install"
            yes | sudo pacman -S kitty tmux zsh -y
	    git clone https://aur.archlinux.org/yay.git 
    	    cd yay
	    yes | makepkg -si
        fi
    done

    # DOCKER
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

    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc

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
    1) Arch_Install ;;
    2) Deb_Install ;;
    3) Fedora_Install ;;
    4) Wsl_Debian_install ;;
    5) Wsl_Arch_install ;;
    6) exit ;;
    esac

    read -p "Press enter to continue...."
done
