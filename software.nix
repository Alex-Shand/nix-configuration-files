# Software not automatically installed by other files and package configuration
{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    # For notify function in bashrc
    libnotify

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

    # Drop down terminal
    yakuake

    # Dotfiles
    homesick

    # Archives
    ark
    unzip

    # Editors (vscode has its own file)
    kate
    emacs
    texmaker

    # Git
    git
    meld

    # Spell checking for emacs
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    # Mount NTFS drives
    ntfs3g

    # Dropbox
    maestral

    # RSS
    liferea

    # Misc
    discord
    file
    appimage-run
    sshfs
    calibre
    distrobox
  ];

  # Permits installation of non-free and non-open-source components
  nixpkgs.config.allowUnfree = true;
}
