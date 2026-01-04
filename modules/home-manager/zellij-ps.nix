{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.zellij-ps;
in {
  options = {
    programs.zellij-ps = {
      enable = mkEnableOption "Zellij Project Selector";
      projectFolders = mkOption {
        type = types.listOf types.path;
        description = "List of project folders to search for projects";
        default = ["${config.home.homeDirectory}/projects"];
      };
      layout = mkOption {
        type = types.str;
        description = "Layout to use for the project selector";
        default = ''
          layout {
                       pane size=1 borderless=true {
                           plugin location="zellij:tab-bar"
                       }
                       pane
                       pane split_direction="vertical" {
                           pane
                           pane command="htop"
                       }
                       pane size=2 borderless=true {
                           plugin location="zellij:status-bar"
                       }
                   }
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.zellij-ps];
    home.sessionVariables.PROJECT_FOLDERS = lib.concatStringsSep ":" cfg.projectFolders;
    home.file.".config/zellij/layouts/zellij-ps.kdl".text = cfg.layout;
  };
}
