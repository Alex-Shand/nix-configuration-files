{ config, pkgs, ... }:

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

      # DNS servers
      insertNameservers = [ "1.1.1.1" "1.0.0.1" ];

    };

  };

}
