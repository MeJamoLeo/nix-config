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
  };

  outputs = { self, nixpkgs, home-manager }: 
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
        ];
      };
    };
  };
}

