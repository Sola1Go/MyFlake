{ config, pkgs, lib, ... }:

{
  nix.distributedBuilds = true;
  nix.buildMachines = [{
    hostName = "sisyphus";
    system = "x86_64-linux";
    supportedFeatures = [ "kvm" "nixos-test" "big-parallel" "benchmark" ];
    speedFactor = 2;
    sshUser = "root";
    maxJobs = 3;
  }];
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';

  nix.binaryCaches = lib.mkForce [
      "http://sisyphus:3001/"
      "https://cache.nixos.org/"
    ];

  nix.binaryCachePublicKeys =
      [ "sisyphus:A+04lWKcliP1HDMpJZCvjPwM0ZMPjRpU8zijgDsHjpk=" ];

  nix.trustedBinaryCaches = [ "http://sisyphus:3001/" ];

}
