{ config, pkgs, ... }:

{

  users = {

    users.alex = {

      # Creates a home directory at "/home/alex", sets group to users and default
      # shell to users.defaultUserShell (Seems to be bash by default)
      isNormalUser = true;

      extraGroups = [
        
        # Use sudo 
        "wheel"

        # Control the network with networkmanager
        "networkmanager"

        # Enable interaction with libvirt
        "libvirtd"

        # Use docker
        "docker"

      ];

      # Default password is 'q' create a new one with mkpasswd -m sha-512 after
      # install
      hashedPassword = "$6$mqUlRskti$ju4lJHszAPHB7s7PXY7l.mx67iWIT0bmUU1RUYXDX26s8OEL8/QwueE4RQPZFddiKy66Gvl2HMm.4xTgIgOKj.";
      
    };

    # Users can only be added and modified by changing the configuration files
    # (As a result there's currently no root user)
    mutableUsers = false;

  };
  
}
