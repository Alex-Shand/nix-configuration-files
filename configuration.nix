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
    # Hardware configuration created by installer
    ./hardware-configuration.nix
    # Partitions, bootloader etc, probably shouldn't be changed post install
    ./invariant.nix
    # Localisation + Timezone
    ./locale.nix
    # User accounts
    ./users.nix
    # Sound
    ./sound.nix
    # GUI
    ./kde.nix
    # Networking
    ./network.nix
    ] ++ (if first_install then [] else [
    # General Software
    ./software.nix
    # VSCode
    ./vscode.nix
    ]);

  # Hardlink identical files if possible
  nix.settings.auto-optimise-store = true;

  # Run fcron daemon
  services.fcron.enable = true;

  # Run at daemon
  services.atd.enable = true;

  # Setup adb and fastboot
  programs.adb.enable = true;

  services.teamviewer.enable = true;

  # Set vim as default editor for all users
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  # Show password stars for sudo
  security.sudo.extraConfig = "Defaults env_reset, pwfeedback";

  # The NixOS release to be compatible with for stateful data such as databases
  system.stateVersion = "23.11";

  boot.binfmt = {
    emulatedSystems = [ "aarch64-linux" ];
    preferStaticEmulators = true;
  };

  services.tailscale.enable = true;
  services.mullvad-vpn.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.incus.enable = true;
  # Required for incus
  networking.nftables.enable = true;
  networking.firewall.trustedInterfaces = [ "incusbr0" ];
  networking.firewall.interfaces.incusbr0.allowedTCPPortRanges = [{ from = 0; to = 65535; }];
  networking.firewall.interfaces.incusbr0.allowedUDPPortRanges = [{ from = 0; to = 65535; }];

}
