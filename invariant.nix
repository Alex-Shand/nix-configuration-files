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

# Variables for Windows boot entry (For desktop):
# Run:
# export WIN=/mnt/boot/EFI/Microsoft/Boot/bootmgfw.efi
# grub-probe --target=hints_string $WIN
# grub-probe --target=fs_uuid $WIN

# First output goes here
win_hints_string = "--hint-bios=hd0,gpt1 --hint-efi=hd0,gpt1 --hint-baremetal=ahci0,gpt1";

# Second output goes here
win_fs_uuid = "069A-66A3";

# Windows Grub Menu entry from wiki.archlinux.org/index.php/GRUB
win_menu_entry = ''
    menuentry "Windows" {
        insmod part_gpt
        insmod fat
        insmod search_fs_uuid
        insmod chain
        search --fs-uuid --set=root ${win_hints_string} ${win_fs_uuid}
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    }
    '';

laptop = (config.var.mode == 1);
desktop = (config.var.mode == 2);

in

{

  boot = {

    # Mount a tmpfs on /tmp
    tmp.useTmpfs = true;

    # Map the cryptsystem partition to /dev/mapper/lvm on boot
    initrd.luks.devices.lvm.device = "/dev/disk/by-partlabel/cryptsystem";

    loader = {

      # Laptop bootloader
      systemd-boot.enable = laptop;
      efi.canTouchEfiVariables = laptop;

      # Desktop bootloader
      grub = {

        enable = desktop;

        # Install to efi
        efiSupport = true;
        device = "nodev";

        # Causes grub to install itself to $EFI_Partition/EFI/boot/boot$arch.efi
        efiInstallAsRemovable = true;

        # Add the Windows menu entry
        extraEntries = win_menu_entry;

      };

      # Disable Timeout
      timeout = -1;

    };

  };

  # Set the options defined above for each btrfs subvolume
  fileSystems = {

    "/" = overrideOptions;

    "/home" = overrideOptions;

    "/.btrfs-root" = overrideOptions;

  };

}
