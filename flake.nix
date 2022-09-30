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
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {


      };

      homeConfigurations.lyc = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home/user-lyc.nix
          ./home/zsh.nix
        ];

      };


    };
}