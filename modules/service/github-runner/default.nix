{ config, pkgs, ... }: {
  config = {

    services.github-runner = {
      enable = false;
      url = "https://github.com/quant-wonderland";
      tokenFile = "/home/lyc/github_action/actions-runner/nixos.token";
      name = "nixos-test";
    };

  };
}
