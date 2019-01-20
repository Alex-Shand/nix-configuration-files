# Software not automatically installed by other files and package configuration
{ config, pkgs, ... }:

let

# Access the unstable channel (Using it kills rebuild times)
unstable = import (
  fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz
);       

in  
{

  environment.systemPackages = with pkgs; [
    networkmanager-openvpn

    # For notify function in bashrc
    libnotify

    # Can be used to hash a password (See users.nix)
    mkpasswd

    # Task list
    taskwarrior

    # Web Browsers
    firefox
    chromium
    tor-browser-bundle

    # Video Codecs + Player
    vlc

    # Passwords
    keepass

    # Image Viewer
    gwenview

    # Office
    libreoffice

    # PDF Viewer
    evince

    # RSS Reader
    quiterss

    # Drop down terminal
    yakuake

    # Dotfiles
    homesick

    # Archive Manager
    ark

    # Editors
    kate
    eclipses.eclipse-platform
    emacs
    android-studio-preview
    texmaker
    coq

    # Git
    git
    meld

    # Spell checking for emacs
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    # Read zip files
    unzip

    # Math stuff
    sage
    octaveFull

  ];

  # Permits installation of non-free and non-open-source components
  nixpkgs.config.allowUnfree = true;

}
