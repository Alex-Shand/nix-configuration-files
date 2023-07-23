# Software not automatically installed by other files and package configuration
{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    # For notify function in bashrc
    libnotify

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
    keepass

    # Image Viewer
    gwenview

    # Office
    libreoffice

    # PDF Viewer
    evince

    # RSS Reader
    #quiterss #Relies on an insecure package, replace

    # Drop down terminal
    yakuake

    # Dotfiles
    homesick

    # Archive Manager
    ark

    # Editors
    kate
    emacs
    texmaker
    vscode

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

    # Mount phone via adb
    adbfs-rootless

    # Mount NTFS drives
    ntfs3g

    discord
    protonvpn-cli
    dropbox
    file
    appimage-run
    sshfs
  ];

  # Permits installation of non-free and non-open-source components
  nixpkgs.config.allowUnfree = true;

}
