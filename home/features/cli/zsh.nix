{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.zsh;
in {
  options.features.cli.zsh.enable = mkEnableOption "enable extended zsh configuration";

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      loginExtra = ''
        export NIX_PATH=nixpkgs=channel:nixos-unstable
        export NIX_LOG=info
        export TERMINAL=kitty
        source /run/agenix/${config.home.username}-secrets

        if [[ "$(tty)" == "/dev/tty1" ]]; then
          exec Hyprland &>/dev/null
        fi
      '';
      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        ls = "eza";
        grep = "rg";
        ps = "procs";
      };
    };
  };
}
