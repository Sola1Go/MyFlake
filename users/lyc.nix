{ config, pkgs, lib, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  
  users = {
    users.lyc = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
      shell = pkgs.zsh;
    };
  };
}
