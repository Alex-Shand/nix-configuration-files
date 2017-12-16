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
    firefoxWrapper
    chromium

    # Video Codecs + Player
    vlc

    # Passwords
    dropbox
    keepass

    # Image Viewer (Should be changed to Gwenview)
    gnome3.eog

    # Office
    libreoffice

    # pdf Viewer
    evince

    # Nix language interpreter
    nix-repl

    # Rss Reader
    quiterss
    
  ];

  # Permits installation of non-free and non-open-source components
  nixpkgs.config.allowUnfree = true;

}
