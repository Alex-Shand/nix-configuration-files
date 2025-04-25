{ config, pkgs, ... }:

let

# Laptop requires touchpad
touchpad = (config.var.mode == 1);

in

{
  services = {
    xserver = {
      # X11
      enable = true;
      # Keyboard layout
      xkb.layout = "us";
      # KDE
      desktopManager.plasma5.enable = true;
    };

    # Display manager
    displayManager.sddm.enable = true;

    # Touchpad driver (If required)
    libinput.enable = touchpad;
  };
}
