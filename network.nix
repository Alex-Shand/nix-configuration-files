{ config, pkgs, ... }:

let

host = if config.var.mode == 1 then "laptop" else "desktop";

in

{
  
  networking = {

    # Set Hostname
    hostName = host;

    # Control the network from the Desktop Manager
    networkmanager = {
      enable = true;
      insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
    };

    # DNS
    #nameservers = [ "1.1.1.1" "1.0.0.1" ];

  };
  
}
