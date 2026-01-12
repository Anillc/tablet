{ config, pkgs, lib, ... }:

with builtins;
with lib;

let
  # TODO: refactor this
  rime-prelude = pkgs.fetchFromGitHub {
    owner = "rime";
    repo = "rime-prelude";
    rev = "3c602fdb0dcca7825103e281efc50ef7580f99ec";
    hash = "sha256-R9sxeCe1e2A3pn//iGwRr3eTTpgxprjEEjlo15/O19c=";
  };
  rime-flypy = pkgs.callPackage ({ stdenv, fetchFromGitHub, librime, ... }: stdenv.mkDerivation {
    name = "rime-flypy";
    src = fetchFromGitHub {
      owner = "cubercsl";
      repo = "rime-flypy";
      rev = "ea9455f25995a2878485c85b111c34a2a897adac";
      hash = "sha256-Lw54pNXUzsVv9OFp7c5Bf+pCCA0DWTslSTrN/raX9CM=";
    };
    nativeBuildInputs = [ librime ];
    prePatch = "cp -r ${rime-prelude}/* .";
    makeFlags = [ "PREFIX=$(out)" ];
  }) {};
in {
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  programs.xwayland.enable = true;
  services.libinput.enable = true;
  services.iptsd = {
    enable = true;
    config.Touchscreen = {
      DisableOnStylus = true;
      DisableOnPalm = true;
    };
  };
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      (fcitx5-rime.override {
        rimeDataPkgs = [ rime-flypy ];
      })
    ];
  };
  fonts.packages = with pkgs; [
    jetbrains-mono
    source-han-sans
    font-awesome
  ] ++ filter isDerivation (attrValues pkgs.nerd-fonts);
  systemd.tmpfiles.rules = [
    "L /run/gdm/.config/monitors.xml     -      -     - - ${./monitors.xml}"
    "L /home/anillc/.config/monitors.xml - anillc users - ${./monitors.xml}"
  ];
  environment.systemPackages = lib.flip map (with pkgs.gnomeExtensions; [
    gjs-osk
    blur-my-shell appindicator disable-gestures-2021
    kimpanel launch-new-instance screen-rotate gsconnect
  ]) (x: x.overrideAttrs (old: let
    version = pkgs.gnome-shell.version
      |> lib.split "\\."
      |> lib.flip lib.elemAt 0;
  in {
    postFixup = (old.postFixup or "") + ''
      FILE=$out/share/gnome-shell/extensions/*/metadata.json
      METADATA=$(cat $FILE)
      echo $METADATA | ${pkgs.jq}/bin/jq '."shell-version" += ["${version}"]' > $FILE
    '';
  }));
  # gsconnect
  networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
}
