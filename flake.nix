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
  };

  outputs = { self, nixpkgs, home-manager, hyprland, hy3, Hyprspace }: 
  let 
    system = "x86_64-linux";
  in {

# =================================
# nixos-configuration
# =================================
  nixosConfigurations.NickeyMouseOS = nixpkgs.lib.nixosSystem {
    modules = [ ./configuration.nix ];
  };



# =================================
# home-manager
# =================================
  homeConfigurations = {
    "treo@nixos" = home-manager.lib.homeManagerConfiguration {
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
              hy3.packages.x86_64-linux.hy3
              Hyprspace.packages.x86_64-linux.Hyprspace
            ];
          };
        }
      ];
    };
  };
};
}

