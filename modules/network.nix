{ config, pkgs, ... }:

{
        networking.useDHCP = false;
        networking.interfaces.enp0s13f0u2u2.useDHCP = true;
        networking.interfaces.wlp165s0.useDHCP = true;

        nixpkgs.config.allowUnfree = true;

        services.openssh.enable = true;
        networking.firewall.enable = false;

}