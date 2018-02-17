# Software not automatically installed by other files and package configuration
{ config, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [

    # Some CLI programs
    #wget
    #dos2unix
    #lsof
    #imagemagick
    #file
    #psmisc
    #libnotify
    #unzip
    #xorg.xhost
    #zip
    #sshfs
    #ffmpeg

    # Can be used to hash a password (See users.nix)
    mkpasswd

    # Task list
    taskwarrior

    # Web Browsers
    firefox
    chromium
    #tor-browser-bundle-bin

    # Video Codecs + Player
    vlc

    # Passwords
    dropbox
    keepass

    # Image Viewer
    #gnome3.eog
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
    
  ];

  # Permits installation of non-free and non-open-source components
  nixpkgs.config.allowUnfree = true;

}
