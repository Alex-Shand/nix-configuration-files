# VSCode and extensions
{ config, pkgs, ... }:

let
  utils = pkgs.vscode-utils;
  system = builtins.currentSystem;
  extensions =
    (import (builtins.fetchGit {
      url = "https://github.com/nix-community/nix-vscode-extensions";
      ref = "refs/heads/master";
      rev = "baeaec5a10fb8626bea64ebabdfaecdf64832bf3";
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
