# Programming languages that are globally available (Mostly they should be setup
# by nix-shell)
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; with perlPackages; [
    
    # Python3 (Installs as python)
    ( python3.withPackages( ps: with ps; [
      #mutagen
      beautifulsoup4
      #tkinter
      #virtualenv
      lxml
      pylint
      #numpy
      cytoolz
      #pypeg2
      #graphviz
      (import ./Python/dominate.nix)
    ]))
    
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
    ListAllUtils
    Autobox
    ( import ./Perl/ArrayUtils.nix )
    ( import ./Perl/LinuxProcMounts.nix )

    # Ruby
    #bundler
    #bundix
    
  ];
  
}
