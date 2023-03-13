#!/bin/bash

set -e

# Default values
use_source=false
source_type=""

function usage {
    echo "Usage: install-nix.sh [OPTIONS]"
    echo "Install Nix for current user."
    echo ""
    echo "Options:"
    echo "  --source TYPE   Install Nix from a specific source. TYPE can be 'tuna' or 'determinate'."
    echo "  -h, --help      Show this help message and exit."
    exit 0
}


# Parse options
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    --source)
      use_source=true
      source_type="$2"
      shift
      shift
      ;;
    -h | --help)
      usage
      ;;
    *)
      echo "Invalid option: $key"
      exit 1
      ;;
  esac
done

if command -v nix &> /dev/null; then
  echo "Nix has already been installed!"
  exit 0
fi

# Install Nix
if [ "$use_source" = true ]; then
  if [ "$source_type" = "tuna" ]; then
    # Install Nix from TUNA mirror
    curl -L https://mirrors.tuna.tsinghua.edu.cn/nix/latest/install | sh
  elif [ "$source_type" = "determinate" ]; then
    # Install Nix from determinate systems mirror
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  else
    echo "Invalid source type: $source_type"
    exit 1
  fi
else
  # Install Nix via official install script
  sh <(curl -L https://nixos.org/nix/install) --daemon
fi

