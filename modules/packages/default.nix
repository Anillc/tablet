{ config, pkgs, lib, inputs, ... }:

with builtins;
with lib;

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.trusted-users = [ "@wheel" ];
  programs.command-not-found.enable = false;
  programs.adb.enable = true;
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    (callPackage ./vscode.nix {
      volar-pkgs = import inputs.nixpkgs-volar { system = pkgs.system; };
    })
    (agda.withPackages (p: [ p.standard-library p.cubical ]))
    telegram-desktop
    qq
    thunderbird
    xournalpp
    zotero
  ];
}
