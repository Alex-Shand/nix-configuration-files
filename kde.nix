{ config, pkgs, ... }:

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

    # Touchpad driver
    libinput.enable = true;
  };
}
