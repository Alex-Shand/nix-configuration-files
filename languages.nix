# Programming languages that are globally available (Mostly they should be setup
# by nix-shell)
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; with perlPackages; [
    
    # Python3 (Installs as python)
    ( python3.withPackages( ps: with ps; [
      # Should install librarys here, pip is only for maintaining an up to date
      # youtube-dl
      pip
      mutagen
      beautifulsoup4
      tkinter
      virtualenv
      lxml
      pylint
      numpy
      opencv3
    ]))

    opencv3

    # Perl
    # Tool to generate nix expressions for cpan modules
    nix-generate-from-cpan
    # Perl Modules from Nix or generated from the above
    FileHomeDir
    FileFindRulePerl
    XMLSimple
    LWP
    HTMLTokeParserSimple
    IPCSystemSimple
    ( import ./Perl/ArrayUtils.nix )
    ( import ./Perl/LinuxProcMounts.nix )

    # Ruby
    bundler
    bundix

    # Octave
    octaveFull

    # IDEs
    eclipses.eclipse-platform
    emacs
    android-studio-preview
    
  ];
  
}
