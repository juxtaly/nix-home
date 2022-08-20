#!/bin/bash
set -e

install_nix() {
    curl -L https://mirrors.tuna.tsinghua.edu.cn/nix/latest/install | sh
    . ~/.nix-profile/etc/profile.d/nix.sh
}

replace_mirror() {
    mkdir -p ~/.config/nix/
    echo "substituters = https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://cache.nixos.org/" >> ~/.config/nix/nix.conf
    nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable nixpkgs
    nix-channel --update
}

install_home_manager() {
    ln -s $(pwd) ~/.config/nixpkgs
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    export NIX_PATH=$HOME/.nix-defexpr/channels:${NIX_PATH:+:$NIX_PATH}
    nix-shell '<home-manager>' -A install
    . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
}

generate_user_home() {
    sed -e "s?@HOME@?${HOME}?" -e "s?@USER@?${USER}?" ./user.nix.in > ./user.nix
}

clean_and_switch() {
    rm -rf ~/.config/nix
    nix-env -e gum
    home-manager switch
}

if ! command -v nix &> /dev/null; then
    echo "Installing nix..."
    install_nix
else
    echo "Nix is already installed."
fi

command -v gum &> /dev/null || nix-env -iA nixpkgs.gum

test -e ./user.nix || generate_user_home

gum confirm "Replace mirror?" && replace_mirror

gum confirm "Install home-manager?" && install_home_manager

gum confirm "clean and switch?" && clean_and_switch
