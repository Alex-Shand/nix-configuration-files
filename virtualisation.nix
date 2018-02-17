{ config, pkgs, ... }:

{

  virtualisation = {
    # Libvirt for general virtual machines
    libvirtd.enable = true;
    # For Vagrant
    virtualbox.host.enable = true;
    # Docker
    docker.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    
    # GUI for managing machines
    virtmanager
    
    # Something to do with networking I think
    bridge-utils

    # VM Provisioner
    vagrant
    
  ];

}
