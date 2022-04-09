set -e

curl -L https://mirrors.tuna.tsinghua.edu.cn/nix/latest/install | sh

. ~/.nix-profile/etc/profile.d/nix.sh

# replace nix mirror
mkdir -p ~/.config/nix/
echo "substituters = https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://cache.nixos.org/" >> ~/.config/nix/nix.conf
nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable nixpkgs
nix-channel --update

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install
. $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

ln -s $(pwd) ~/.config/nixpkgs

home-manager switch
