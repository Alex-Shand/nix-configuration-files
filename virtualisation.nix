{ config, pkgs, ... }:

{

  # Libvirt for general virtual machines
  virtualisation.libvirtd.enable = true;
  virtualisation.virtualbox.host.enable = true;
  
  environment.systemPackages = with pkgs; [
    
    # GUI for managing machines
    virtmanager
    
    # Something to do with networking I think
    bridge-utils
    
  ];

}
