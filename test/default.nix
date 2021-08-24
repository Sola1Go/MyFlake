{ pkgs ? import <nixpkgs> { } }: { test = pkgs.nixosTest ./login.nix; }
