# Software not automatically installed by other files and package configuration
{ config, pkgs, ... }:

let
  unstable = import (
    fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz
  );
in
{
  
  environment.systemPackages = with pkgs; [

    #unstable.weechat

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

    # pdf Viewer
    evince

    # Nix language interpreter
    nix-repl
    #indent
    
    # Rss Reader
    quiterss

    # Drop down terminal
    yakuake

    # Dotfiles
    homesick

    # Archive Manager
    ark

    # Text Editor
    kate

    # Git
    git
    meld

    # Ecrypted file system
    encfs

    # Read zip files
    unzip

    # Math stuff
    sage
    
  ];

  # Permits installation of non-free and non-open-source components
  nixpkgs.config.allowUnfree = true;

}
