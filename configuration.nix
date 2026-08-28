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

  security.sudo.wheelNeedsPassword = true;

  # Hardlink identical files if possible
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "alex" ];

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
  services.mullvad-vpn.enableExcludeWrapper = true;

  virtualisation.docker = {
    enable = true;
    #rootless = {
    #  enable = true;
    #  setSocketVariable = true;
    #  daemon.settings.dns = [
    #    # For off VPN
    #    "1.1.1.1"
    #    "1.0.0.1"
#
#        # For on VPN
#        "10.64.0.1"
#      ];
#    };
  };
  virtualisation.incus.enable = true;
  # Required for incus
  networking.nftables.enable = true;
  networking.nftables.ruleset =  ''
      define EXCLUDED_SUBNET = { 10.10.5.0/24 }

      table inet excludeTraffic {
        chain excludeOutgoing {
          type route hook output priority -150; policy accept;
          ip daddr $EXCLUDED_SUBNET ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }

        chain excludeForwarding {
          type filter hook prerouting priority -150; policy accept;
          ip saddr $EXCLUDED_SUBNET ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }
      }
    '';
  networking.firewall.trustedInterfaces = [ "incusbr0" "incusbr1" ];
  networking.firewall.interfaces.incusbr0.allowedTCPPortRanges = [{ from = 0; to = 65535; }];
  networking.firewall.interfaces.incusbr0.allowedUDPPortRanges = [{ from = 0; to = 65535; }];
  networking.firewall.interfaces.incusbr1.allowedTCPPortRanges = [{ from = 0; to = 65535; }];
  networking.firewall.interfaces.incusbr1.allowedUDPPortRanges = [{ from = 0; to = 65535; }];

}
