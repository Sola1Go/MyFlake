{ config, pkgs, lib, ... }:

{
  nix.distributedBuilds = true;
  nix.buildMachines = [{
    hostName = "sisyphus";
    system = "x86_64-linux";
    supportedFeatures = [ "kvm" "nixos-test" "big-parallel" "benchmark" ];
    speedFactor = 2;
    sshUser = "lyc";
    maxJobs = 3;
  }];
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';


  nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" "http://sisyphus:3001/"];

  nix.settings.trusted-public-keys =
      [ "sisyphus:A+04lWKcliP1HDMpJZCvjPwM0ZMPjRpU8zijgDsHjpk=" ];

  nix.settings.trusted-substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" "http://sisyphus:3001/" ];

}
