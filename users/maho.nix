{ config, pkgs, lib, ... }: {
  users.users.maho = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
  };
}