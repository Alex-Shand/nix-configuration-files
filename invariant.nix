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
win_hints_string = "--hint-bios=hd0,gpt2 --hint-efi=hd0,gpt2 --hint-baremetal=ahci0,gpt2";

# Second output goes here
win_fs_uuid = "488C-5E97";

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

# Desktop needs a Windows menu entry
desktop = (config.var.mode == 2);

in

{
  
  boot = {
    
    # Map the cryptsystem partition to /dev/mapper/lvm on boot
    initrd.luks.devices.lvm.device = "/dev/disk/by-partlabel/cryptsystem";
    
    loader = {
      
      grub = {
        
        # Use Grub2
        enable = true;
        version = 2;
        
        # Install to efi
        efiSupport = true;
        device = "nodev";
        
        # Causes grub to install itself to $EFI_Partition/EFI/boot/boot$arch.efi
        efiInstallAsRemovable = true;

        # Add the Windows menu entry if requried
        extraEntries = if desktop then win_menu_entry else "";
        
      };
      
      # Disable Timeout
      timeout = -1;
      
    };
    
  };
  
  # Set the options defined above for each btrfs subvolume
  fileSystems = {
    
    "/" = overrideOptions;
    
    "/home" = overrideOptions;
    
    "/home/.snapshots" = overrideOptions;
    
    "/home/alex/outside" = overrideOptions;
    
    "/.btrfs-root" = overrideOptions;
    
  };

  # This seems to be required to reliably get sound
  hardware.pulseaudio.enable = true;

}
