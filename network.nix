{ config, pkgs, lib, ... }:

{
  networking = {
    # Set Hostname
    hostName = "laptop";
    networkmanager = {
      # Control the network from the Desktop Manager
      enable = true;
      insertNameservers = ["1.1.1.1" "1.0.0.1"];
    };
  };

  # For RaspberryPi
  services.avahi = {
      enable = true;
      nssmdns4 = true;
  };
}
