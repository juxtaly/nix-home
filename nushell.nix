{
  config,
  lib,
  pkgs,
  ...
}: {
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
    '';
    extraConfig = ''
      source ~/.zoxide.nu
      source ~/.broot.nu
      source ~/.carapace.nu
    '';
  };
}
