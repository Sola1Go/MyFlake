{

  description = "All of our deployment, period";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05"; };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {

        lxb = nixpkgs.lib.nixosSystem rec {
          inherit system;
          modules = [ ./machines/lxb ];
        };
      };

      devShell."${system}" = pkgs.mkShell rec {
        name = "nix-test";

        buildInputs = with pkgs; [ pkgs.nixosTest ./login.nix ];

        shellHook = ''
          export PS1="$(echo -e '\uf3e2') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
        '';
      };

    };
}
