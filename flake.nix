{

  description = "All of our deployment, period";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    utils.url = "github:numtide/flake-utils";
    utils.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {

        lyc = nixpkgs.lib.nixosSystem rec {
          inherit system;
          
          modules = [
            ({
              nixpkgs.overlays = [
                (final: prev: {
                  vscode-latest = pkgs.vscode;
                })
              ];
            })
            ./machines/lyc

          ];
        };


      };
      homeConfigurations.lyc = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home/user-lyc.nix
          ./home/zsh.nix
        ];

      };

      homeConfigurations.maho = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home/user-maho.nix
          ./home/zsh.nix
        ];

      };


    };
}