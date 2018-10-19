# Collects configuration from other files and holds options not worth a separate
# file by themselves
{ config, pkgs, ... }:

let

# If true don't install non-essential stuff (Stops the live OS from running out
# of space in /nix/store)
first_install = false;

in

{

  imports =  [
    # The NixOS release to be compatible with for stateful data such as
    # databases (Seperated to allow for the possibility of laptop and desktop
    # having different NixOS versions)
    ./version.nix
    # Hardware configuration created by installer
    ./hardware-configuration.nix
    # It seems options can't be defined in configuration.nix so this defines
    # var.mode used below
    ./options.nix
    # Partitions, bootloader etc, probably shouldn't be changed post install
    ./invariant.nix
    # Localisation + Timezone
    ./locale.nix
    # User accounts
    ./users.nix
    ] ++ (if first_install then [] else [
    # Networking
    ./network.nix
    # General Software
    ./software.nix
    # Programming Languages
    ./languages.nix
    # GUI
    ./kde.nix
    # Virtualisation
    ./virtualisation.nix
    ]);

  # Installation Mode (1=laptop, 2=desktop)
  var.mode = 2;

  # Hardlink identical files if possible
  nix.autoOptimiseStore = true;

  # Run fcron deamon
  services.fcron.enable = true;

  # Setup adb and fastboot
  programs.adb.enable = true;

  # Set vim as default editor for all users
  programs.vim.defaultEditor = true;

  # Show password stars for sudo
  security.sudo.extraConfig = "Defaults env_reset, pwfeedback";
}
