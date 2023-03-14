{
  config,
  lib,
  pkgs,
  ...
}: let
  nu_scripts = pkgs.fetchFromGitHub {
    owner = "nushell";
    repo = "nu_scripts";
    rev = "main";
    sha256 = "sha256-Sl7Y6pLv8hKWH77gQgXpsSG0Mr41vjrOhGuIRkQeMj4=";
  };
in {
  # Tools may not be compatible
  # mcfly
  # fzf
  # Tools have integration in home-manager
  # starship
  # direnv
  # Tools have built-in functions to integrate
  # zoxide
  # broot
  # carapace
  programs.nushell = {
    enable = true;
    envFile.source = ./support/nushell/env.nu;
    configFile.source = ./support/nushell/config.nu;
    extraEnv = ''
      if not ('~/.zoxide.nu' | path exists) {
        zoxide init nushell | save -f ~/.zoxide.nu
      }
      if not ('~/.broot.nu' | path exists) {
        broot --print-shell-function nushell | save -f ~/.broot.nu
      }
      if not ('~/.carapace.nu' | path exists) {
        carapace _carapace nushell | save -f ~/.carapace.nu
      }
      let-env NU_LIB_DIRS = ($env.NU_LIB_DIRS | prepend [ ${nu_scripts} ])

      if '~/.env_local.nu' | path exists {
        source ~/.env_local.nu
      }
    '';
    extraConfig = ''
      source ~/.zoxide.nu
      source ~/.broot.nu
      source ~/.carapace.nu
      if '~/.config_local.nu' | path exists {
        source ~/.config_local.nu
      }
    '';
  };
}
