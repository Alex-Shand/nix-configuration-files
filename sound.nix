# Sound config (https://nixos.wiki/wiki/PipeWire)
{ config, pkgs, ... }:

{

  # Pipewire for sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # For Bluetooth Audio
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

}
