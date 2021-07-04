{ config, lib, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users = {
    extraUsers.liuxb = {
     isNormalUser = true;
     initialHashedPassword = lib.mkDefault "$6$c7xWgHnMCJKXlPHK$2Owbgw3Y5z/pgwD76O45nPzuRtABjN.Mr6M.yO1jOteDyVsXSOqgzgkAl1sD1kIowEQRFIoyXT45j8ZLmZ5SF1";
     uid = 1002;
     home = "/home/liuxb";
     description = "The user liuxb.";
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   };
 };
}
