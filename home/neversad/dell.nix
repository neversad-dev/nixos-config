{config, ...}: {
  imports = [
    ./home.nix
    ../common
    ../features/cli
    ../features/desktop
    ./dotfiles
  ];

  features = {
    cli = {
      zsh.enable = true;
      fzf.enable = true;
      neofetch.enable = true;
    };
    desktop = {
      fonts.enable = true;
      wayland.enable = true;
      hyprland.enable = true;
    };
  };

  wayland.windowManager.hyprland = {
    settings = {
      device = [
        {
          name = "keyboard";
          kb_layout = "us";
        }
        {
          name = "mouse";
          sensitivity = -0.5;
        }
      ];
      monitor = [
        "LVDS-1,1366x768@60,0x0,1"
      ];
      workspace = [
        "1, monitor:LVDS-1, default:true"
        "2, monitor:LVDS-1"
        "3, monitor:LVDS-1"
        "4, monitor:LVDS-1"
      ];
    };
  };
}
