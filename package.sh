#!/usr/bin/env bash
# ARCH INSTALL
arch_install() {
    yes | sudo pacman -Syuu
    yes | sudo pacman -Syu base-devel

    # Install git, go, curl
    yes | sudo pacman -S git go curl

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

    # CODE
    yes | yay -S visual-studio-code-bin

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

    # ZSH

    # yes | sudo pacman -Sy zsh
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    # git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
    # git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

    #Open .zshrc

    #nano ~/.zshrc

    #Find the line which says plugins=(git).

    #Replace that line with plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)

}

# Deb BASES INSTALL
deb_install() {
    sudo apt install gcc build-essential openjdk-17-jdk openjdk-17-jre zsh gettext wget curl -y

    sudo apt upgrade -y

    # Flatpak modules

    sudo apt install flatpak -y

    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    flatpak install flathub com.discordapp.Discord io.beekeeperstudio.Studio io.dbeaver.DBeaverCommunity com.github.sdv43.whaler -y

    # OH MY ZSH

    #sudo apt install zsh-autosuggestions zsh-syntax-highlighting zsh -y
    #sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    # git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
    # git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

    #Open .zshrc

    #nano ~/.zshrc

    #Find the line which says plugins=(git).

    #Replace that line with plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)

    # Programing modules

    # GOLANG MODULE INSTALL
    wget https://go.dev/dl/go1.20.3.linux-amd64.tar.gz
    rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz

    export PATH=$PATH:/usr/local/go/bin

    # RUST MODULE
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    source $HOME/.cargo/env

    #NPM
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
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

}

# WSL_INSTALL
Wsl_Debian_install() {
    sudo apt upgrade -y

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
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
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
}

#Wsl ARCH
Wsl_Arch_install() {

    yes | sudo pacman -Syu base-devel

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

    # ZSH

    # yes | sudo pacman -Sy zsh
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    # git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
    # git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

    #Open .zshrc

    #nano ~/.zshrc

    #Find the line which says plugins=(git).

    #Replace that line with plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)
}

#Main Menu

while true; do
    clear
    echo "Packages for distros"
    echo "--------------------"
    echo "1. Arch Linux"
    echo "2. Debian bases"
    echo "3. Wsl_Debian_install"
    echo "4. Wsl_Arch_install"
    echo "5. exit"

    read -p "Enter number " choice

    case $choice in
    1) arch_install ;;
    2) deb_install ;;
    3) Wsl_Debian_install ;;
    4) Wsl_Arch_install ;;
    5) exit ;;
    esac

    read -p "Press enter to continue...."
done
