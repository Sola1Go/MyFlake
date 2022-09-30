

{ config, pkgs, ... }:

{
  home.username = "lyc";
  home.homeDirectory = "/home/lyc";

  home.packages = [
    pkgs.nixpkgs-fmt
    pkgs.conda
  ];

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Sola1Go";
    userEmail = "30356570@qq.com";
    signing = {
      key = "30356570@qq.com";
      signByDefault = false;
    };
  };

  home.file = {
    ".config/nix/nix.conf".source = ./files/.config/nix/nix.conf;
  };

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}