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

    };

    # Touchpad driver (If required)
    synaptics.enable = touchpad;

  };
  
}
