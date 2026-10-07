{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.trusted-users = [ "@wheel" ];
  programs.nix-ld.enable = true;
  programs.command-not-found.enable = false;

  environment.systemPackages = with pkgs; [
    android-tools
    (agda.withPackages (p: [ p.standard-library p.cubical ]))
    telegram-desktop
    thunderbird
    xournalpp
    # zotero  # temporarily disabled: zotero-10.0.4 fails to build (Firefox ESR 153 vs 140 mismatch in nixpkgs)
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
