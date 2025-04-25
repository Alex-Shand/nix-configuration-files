# Programming languages that are globally available (Mostly they should be setup
# by nix-shell)
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # Python3 (Installs as python)
    (python314.withPackages( ps: with ps; [
      beautifulsoup4
      virtualenv
      lxml
      pylint
      cytoolz
      mypy
      requests
      progress
      pytest
      xmltodict
    ]))

    # Perl (I think this is just for the password remover script in this repo?)
    perl

    # Latex
    texlive.combined.scheme-full

    # Make
    gnumake

  ];
}
