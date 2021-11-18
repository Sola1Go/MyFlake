{ config, pkgs, ... }:

{
  networking.useDHCP = false;

  networking.hostName = "lxb";
  # head -c 8 /etc/machine-id
  networking.hostId = "e6164dca";
  

  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;
  networking.firewall.enable = false;
  networking.networkmanager.enable = true;

  services.strongswan = {
    enable = true;
    secrets = [ "ipsec.d/ipsec.nm-l2tp.secrets" ];
  };
}
