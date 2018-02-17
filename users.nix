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
      hashedPassword = "$6$FnF2dUXK$wqO9bGNELHMph9XDV3vl8t1BnBUT4qDbM.rRw1IStxfcrKSibjciPve4RZtJsUGm47SjSy.kEYTz4sztNd2yu/";
      
    };

    # Users can only be added and modified by changing the configuration files
    # (As a result there's currently no root user)
    mutableUsers = false;

  };
  
}
