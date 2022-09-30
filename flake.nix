{

  description = "All of our deployment, period";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {

        lyc = nixpkgs.lib.nixosSystem rec {
          inherit system;
          modules = [
            ({
              nixpkgs.overlays = [
                (final: prev: {
                  vscode-latest = pkgs-unstable.vscode;
                })
              ];
            })
            ./machines/lyc
          ];
        };
      };

      homeConfigurations.lyc = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs-unstable;

        modules = [
          ./home/user-lyc.nix
          ./home/zsh.nix
        ];

      };
    };
}
