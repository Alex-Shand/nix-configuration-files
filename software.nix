# Software not automatically installed by other files and package configuration
{ config, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [

    # Some CLI programs
    wget
    encfs
    dos2unix
    lsof
    git
    imagemagick
    file
    psmisc
    libnotify
    unzip

    # Can be used to hash a password (See users.nix)
    mkpasswd

    # Task list
    taskwarrior

    # Web Browsers
    firefox
    chromium

    # Video Codecs + Player
    vlc

    # Passwords
    dropbox
    keepass

    # Image Viewer
    gnome3.eog
    gwenview

    # Office
    libreoffice

    # pdf Viewer
    evince

    # Nix language interpreter
    nix-repl

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
    
  ];

  # Permits installation of non-free and non-open-source components
  nixpkgs.config.allowUnfree = true;

}
