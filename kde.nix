{ config, pkgs, ... }:

let

# Laptop requires touchpad
touchpad = (config.var.mode == 1);

in

{

  services.xserver = {

    # Enable the X11 windowing system
    enable = true;
    # Keyboard layout
    layout = "gb";

    desktopManager.plasma5 = {

      # Enable KDE
      enable = true;

      # Optional KDE Packages (Not sure why this is different to the global
      # package list)
      extraPackages = with pkgs; [
        # Archive Manager
        ark
        # Text Editor
        kate
        # Image Viewer
        gwenview
        # Drop down terminal
        yakuake
      ];

    };

    # Touchpad driver (If required)
    synaptics.enable = touchpad;

  };
  
}
