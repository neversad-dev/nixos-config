{
  description = ''
    For questions just DM me on X: https://twitter.com/@m3tam3re
    There is also some NIXOS content on my YT channel: https://www.youtube.com/@m3tam3re

    One of the best ways to learn NIXOS is to read other peoples configurations. I have personally learned a lot from Gabriel Fontes configs:
    https://github.com/Misterio77/nix-starter-configs
    https://github.com/Misterio77/nix-config

    Please also check out the starter configs mentioned above.
  '';

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    deploy-rs.url = "github:serokell/deploy-rs";

    agenix.url = "github:ryantm/agenix";
    
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles = {
      url = "git+https://github.com/neversad-dev/dotfiles.git";
      flake = false;
    };
  };

  outputs = {
    self,
    disko,
    agenix,
    home-manager,
    nixpkgs,
    deploy-rs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages =
      forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    overlays = import ./overlays {inherit inputs;};
    homeManagerModules = import ./modules/home-manager;
    nixosConfigurations = {
      dell = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        system = "x86_64-linux";
        modules = [
          inputs.disko.nixosModules.disko
          agenix.nixosModules.default
          ./hosts/dell
        ];
      };
    };
    homeConfigurations = {
      "neversad@dell" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          agenix.homeManagerModules.default
          ./home/neversad/dell.nix
        ];
      };
    };
    deploy = {
      nodes = {
        dell = {
          hostname = "dell";
          profilesOrder = ["system" "neversad"];
          profiles.system = {
            sshUser = "neversad";
            user = "root"; # regular user for home-manager
            interactiveSudo = true;
            remoteBuild = true;
            path =
              deploy-rs.lib.x86_64-linux.activate.nixos
              self.nixosConfigurations.dell;
          };
          profiles.neversad = {
            sshUser = "neversad";
            user = "neversad";
            remoteBuild = true;
            path =
              deploy-rs.lib.x86_64-linux.activate.home-manager
              self.homeConfigurations."neversad@dell";
          };
        };
      };
    };
  };
}
