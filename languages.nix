# Programming languages that are globally available (Mostly they should be setup
# by nix-shell)
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # Generate a nix expression for a pypi module
    pypi2nix
    
    # Python3 (Installs as python)
    ( python3.withPackages( ps: with ps; [
      beautifulsoup4
      virtualenv
      lxml
      pylint
      cytoolz
      numpy
      matplotlib
      tkinter
      mypy
      requests

      (import ./Python/dominate.nix { inherit pkgs; }).packages.dominate
      (import ./Python/progress.nix { inherit pkgs; }).packages.progress
    ]))

    # Perl
    perl

    # Latex
    texlive.combined.scheme-full

    # Make
    gnumake

  ];

}
