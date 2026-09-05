# Options that depend on the install process and can't be simply changed post
# install
{ config, pkgs, ... }:

let

# Overide the device assignments of the subvolumes in the cryptsystem
# partition (The installer doesn't detect it properly)
mapper = pkgs.lib.mkForce "/dev/mapper/sysvg-system";
# Extra options for btrfs subvolumes
btrfs_opts = [ "compress=lzo" "noatime" ];
overrideOptions = { device = mapper; options = btrfs_opts; };

in

{
  boot = {
    # Mount a tmpfs on /tmp
    tmp.useTmpfs = true;

    # Map the cryptsystem partition to /dev/mapper/lvm on boot
    initrd.luks.devices.lvm.device = "/dev/disk/by-partlabel/cryptsystem";

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Set the options defined above for each btrfs subvolume
  fileSystems = {
    "/" = overrideOptions;
    "/home" = overrideOptions;
    "/.btrfs-root" = overrideOptions;
  };
}
