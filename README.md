Prefer NixOS Module: https://github.com/atriw/config

# Usage

## NixOS

## MacOS

## Linux other than NixOS

1. Install Nix
```sh
./support/install-nix.sh [ |tuna|determinate]
```
2. Install Home Manager
```sh
./support/install-home-manager.sh
```
3. Build and switch to first generation
```sh
# home-manager switch --flake '<flake-uri>#<user>'
home-manager switch --flake 'github:atriw/nix-home#matrix'
```

# Known Issues

