{ config, pkgs, ... }:

let

host = if config.var.mode == 1 then "laptop" else "desktop";

in

{
  
  networking = {

    # Set Hostname
    hostName = host;

    # Control the network from the Desktop Manager
    networkmanager.enable = true;

  };
  
}
