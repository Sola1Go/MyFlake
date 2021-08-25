{

  description = "All of our deployment, period";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";

    utils.url = "github:numtide/flake-utils";
    utils.inputs.nixpkgs.follows = "nixpkgs";

    alpha-research.url =
      "git+ssh://git@github.com/quant-wonderland/alpha-research";
    alpha-research.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            alpha-research = inputs.alpha-research.defaultPackage."${system}";
            run-fish-test = pkgs.nixosTest ./test/fish.nix;
          })
        ];
      };
    in {

      defaultPackage."${system}" = pkgs.run-fish-test;

      devShell."${system}" = pkgs.mkShell rec {
        name = "nix-test";

        buildInputs = [ ];

        defaultPackage = pkgs.run-fish-test;

        shellHook = ''
          export PS1="$(echo -e '\uf3e2') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
        '';
      };

      nixosConfigurations = {

        lxb = nixpkgs.lib.nixosSystem rec {
          inherit system;
          modules = [ ./machines/lxb ];
        };

      };

    };
}
