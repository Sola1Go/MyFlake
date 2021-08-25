let
  system = "x86_64-linux";
  datawarehouse = builtins.fetchGit {
    url = "git+ssh://git@github.com/quant-wonderland/data-warehouse";
    ref = "master";
  };
  nixpkgs = builtins.fetchGit {
    url = "https://github.com/liuhh666233/nixpkgs.git";
    ref = "nixos-21.05";
  };
  #   nixpkgs.overlays = [
  #     (final: prev: { warehouse = datawarehouse.defaultPackage."${system}"; })
  #   ];
  pkgs = import nixpkgs { };
in pkgs.nixosTest ({
  name = "jsy-archiver";

  machine = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ datawarehouse ];
  };

  testScript = "";
})
