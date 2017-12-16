# Defines an option to export the install mode into the global configuration
# (Seems this can't be done in configuration.nix)
{ config, lib, pkgs, ... }:

with lib;

{
  options.var.mode = mkOption { type = types.int; };
}
