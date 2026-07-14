{ config, pkgs, ... }:

{
  virtualisation = {
    # Libvirt for general virtual machines
    libvirtd.enable = true;
    # For Vagrant
    virtualbox.host.enable = true;
    # Docker
    docker = {
      enable = false;
      rootless = {
        enable = true;
        setSocketVariable = true;
        daemon.settings.dns = [ "1.1.1.1", "1.0.0.1" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # GUI for managing machines
    virt-manager
    # Something to do with networking I think
    bridge-utils
    # VM Provisioner
    vagrant
  ];
}
