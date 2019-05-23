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

    # Enable KDE
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    # Touchpad driver (If required)
    libinput.enable = touchpad;

  };

}
