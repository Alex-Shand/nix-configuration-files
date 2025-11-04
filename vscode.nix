# VSCode and extensions
{ config, pkgs, ... }:

let
  utils = pkgs.vscode-utils;
  system = builtins.currentSystem;
  extensions =
    (import (builtins.fetchGit {
      url = "https://github.com/nix-community/nix-vscode-extensions";
      ref = "refs/heads/master";
      ######
      rev = "5d6525e4d5372973da1777b9ebdb01f033db1395";
      ######
    })).extensions.${system};

  builder = import ./local_extension.nix { builder = utils.buildVscodeExtension; };
  theomach = builder { name = "theomach"; src = /home/alex/.local/bin/theomach.vsix.zip; };
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
        stkb.rewrap
        mattn.lisp
      ] ++ (if theomach != null then [ theomach ] else []);
    })
  ];
}