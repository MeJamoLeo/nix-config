{
  description = "A NixOS configuration flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };

    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    hy3,
    Hyprspace,
    split-monitor-workspaces,
  }: 
  let 
    system = "x86_64-linux";
  in {

# =================================
# nixos-configuration
# =================================
  nixosConfigurations.budou = nixpkgs.lib.nixosSystem {
    modules = [ ./configuration.nix ];
  };



# =================================
# home-manager
# =================================
  homeConfigurations = {
    "treo@budou" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # プロプライエタリなパッケージを許可
      };
      modules = [
        ./home.nix
        hyprland.homeManagerModules.default
        {
          wayland.windowManager.hyprland = {
            enable = true;
            plugins = [
              hy3.packages.${system}.hy3
              Hyprspace.packages.${system}.Hyprspace
              split-monitor-workspaces.packages.${system}.split-monitor-workspaces
            ];
          };
        }
      ];
    };
  };
};
}

