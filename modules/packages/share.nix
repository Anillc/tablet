{ kdeconnect, xclip, lib, libnotify, writeScriptBin, ... }:

with builtins;
with lib;

writeScriptBin "share-file" ''
  export PATH=$PATH:${makeBinPath [ xclip kdeconnect libnotify ]}
  ID=$(kdeconnect-cli -a --id-only)
  if [ -z "$ID" ]; then
    echo "Coudn't find a device."
    notify-send 'share-file' "Coudn't find a device."
    exit 1
  fi
  if [ ! -z "$1" ]; then
    kdeconnect-cli -d $ID --share $1
    notify-send 'share-file' '✓'
    exit 0
  fi
  IMG=$(mktemp).png
  xclip -selection clipboard -t image/png -o > $IMG
  if [ ! $? -eq 0 ]; then
    echo "No image in clipboard"
    notify-send 'share-file' "No image in clipboard"
    exit 1
  fi
  kdeconnect-cli -d $ID --share $IMG
  notify-send 'share-file' '✓'
''