{ config, pkgs, ... }:
let
  proxyConfig = { listenPort, proxyUrl, extraLocations ? { }, }: {
    forceSSL = false;
    enableACME = false;

    basicAuthFile = ./admin;

    listen = [{
      addr = "0.0.0.0";
      port = listenPort;
    }];
    locations = { "/" = { proxyPass = proxyUrl; }; } // extraLocations;
  };
in {
  config = {

    services.nginx = {
      enable = true;
      # Enable recommended proxy settings.
      recommendedProxySettings = true;
      # Enable recommended TLS settings.
      recommendedTlsSettings = true;
      # Enable recommended optimisation settings.
      recommendedOptimisation = true;

      virtualHosts."127.0.0.1" = proxyConfig {
        listenPort = 10000;
        proxyUrl = "http://localhost:5555";
      };

    };

    networking.firewall.allowedTCPPorts = [ 10000 ];
  };
}
