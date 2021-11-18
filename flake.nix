{

  description = "All of our deployment, period";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable,... }@inputs:
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
            vital-modules.nixosModules.foundation
            ({
              nixpkgs.overlays = [
                (final: prev: {
                  google-chrome-latest = pkgs-unstable.google-chrome-beta;
                })
              ];
            })
            ./machines/lyc
          ];
        };

    };
}
