# VSCode and extensions
{ config, pkgs, ... }:

let

system = builtins.currentSystem;
extensions =
  (import (builtins.fetchGit {
    url = "https://github.com/nix-community/nix-vscode-extensions";
    ref = "refs/heads/master";
    rev = "33e4fe02befed123cafe293b757a7a2324f71b27";
  })).extensions.${system};

in

{

  environment.systemPackages = with pkgs; [
    (vscode-with-extensions.override {
      vscodeExtensions = with extensions.vscode-marketplace; [
        rust-lang.rust-analyzer
        mads-hartmann.bash-ide-vscode
        ms-python.python
        vscjava.vscode-java-pack
        jnoortheen.nix-ide
      ];
    })
  ];

}
