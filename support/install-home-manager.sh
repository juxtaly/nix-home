#!/bin/bash

set -e

if command -v home-manager &> /dev/null; then
  echo "Home Manager has already been installed!"
  exit 0
fi

# Install Home Manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# Print a success message
echo "Home Manager has been installed!"

