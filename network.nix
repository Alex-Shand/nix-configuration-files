{ config, pkgs, lib, ... }:

let

host = if config.var.mode == 1 then "laptop" else "desktop";

in

{
  networking = {
    # Set Hostname
    hostName = host;
    networkmanager = {
      # Control the network from the Desktop Manager
      enable = true;
      insertNameservers = ["1.1.1.1" "1.0.0.1"];
      # insertNameservers = [ "100.64.0.1" "100.64.0.2" ];
    };
    # nameservers = [ "100.64.0.1" "100.64.0.2" ];
  };

  # For RaspberryPi
  services.avahi = {
      enable = true;
      nssmdns4 = true;
  };
}
