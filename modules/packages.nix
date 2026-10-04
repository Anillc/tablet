{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.trusted-users = [ "@wheel" ];
  programs.nix-ld.enable = true;
  programs.command-not-found.enable = false;

  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    (agda.withPackages (p: [ p.standard-library p.cubical ]))
    telegram-desktop
    thunderbird
    xournalpp
    zotero
  ];

  environment.persistence."/persist".users.anillc.directories = [
    ".config/attic"
    ".config/npm-token"
    ".config/sops"
    ".config/vivaldi"
    ".config/xournalpp"
    ".cargo"
    ".codex"
    ".gnupg"
    ".kube"
    ".multica"
    ".ssh"
    ".thunderbird"
    ".zotero"
    "go"
    "multica_workspaces"
    "Zotero"
  ];
}
