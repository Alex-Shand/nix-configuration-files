# Programming languages that are globally available (Mostly they should be setup
# by nix-shell)
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # Python3 (Installs as python)
    ( python3.withPackages( ps: with ps; [
      beautifulsoup4
      virtualenv
      lxml
      pylint
      cytoolz
      (import ./Python/dominate.nix)
      numpy
      matplotlib
      tkinter
      mypy
    ]))

    # Perl
    perl

    # Latex
    texlive.combined.scheme-full

  ];

}
