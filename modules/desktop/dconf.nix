# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "ca/desrt/dconf-editor" = {
      saved-pathbar-path = "/org/gnome/settings-daemon/plugins/power/";
      saved-view = "/org/gnome/settings-daemon/plugins/power/";
      show-warning = false;
      window-height = 500;
      window-is-maximized = true;
      window-width = 540;
    };

    "org/gnome/Console" = {
      font-scale = 1.0;
      last-window-maximised = false;
      last-window-size = mkTuple [ 781 462 ];
    };

    "org/gnome/Extensions" = {
      window-maximized = false;
    };

    "org/gnome/Geary" = {
      migrated-config = true;
    };

    "org/gnome/Snapshot" = {
      is-maximized = false;
      window-height = 640;
      window-width = 800;
    };

    "org/gnome/Totem" = {
      active-plugins = [ "vimeo" "variable-rate" "skipto" "screenshot" "screensaver" "save-file" "rotation" "recent" "movie-properties" "open-directory" "mpris" "autoload-subtitles" "apple-trailers" ];
      subtitle-encoding = "UTF-8";
    };

    "org/gnome/Weather" = {
      window-height = 415;
      window-maximized = false;
      window-width = 992;
    };

    "org/gnome/baobab/ui" = {
      is-maximized = false;
      window-size = mkTuple [ 960 600 ];
    };

    "org/gnome/calculator" = {
      accuracy = 9;
      angle-units = "degrees";
      base = 10;
      button-mode = "advanced";
      number-format = "automatic";
      show-thousands = false;
      show-zeroes = false;
      source-currency = "DZD";
      source-units = "degree";
      target-currency = "DZD";
      target-units = "degree";
      word-size = 64;
    };

    "org/gnome/calendar" = {
      active-view = "month";
      window-maximized = true;
      window-size = mkTuple [ 768 600 ];
    };

    "org/gnome/cheese" = {
      burst-delay = 1000;
    };

    "org/gnome/control-center" = {
      last-panel = "universal-access";
      window-state = mkTuple [ 980 640 false ];
    };

    "org/gnome/desktop/a11y" = {
      always-show-universal-access-status = false;
    };

    "org/gnome/desktop/a11y/applications" = {
      screen-keyboard-enabled = false;
    };

    "org/gnome/desktop/a11y/keyboard" = {
      enable = false;
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [ "Utilities" "YaST" ];
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [ "gnome-abrt.desktop" "gnome-system-log.desktop" "nm-connection-editor.desktop" "org.gnome.Connections.desktop" "org.gnome.DejaDup.desktop" "org.gnome.Dictionary.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.eog.desktop" "org.gnome.Evince.desktop" "org.gnome.FileRoller.desktop" "org.gnome.fonts.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" "vinagre.desktop" "org.gnome.baobab.desktop" ];
      categories = [ "X-GNOME-Utilities" ];
      excluded-apps = [ "org.gnome.Console.desktop" ];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = [ "X-SuSE-YaST" ];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/anillc/.local/share/backgrounds/2023-06-21-19-22-44-%7BA549BEAA-044A-36B6-C635-188798168B17%7D.png";
      picture-uri-dark = "file:///home/anillc/.local/share/backgrounds/2023-06-21-19-22-44-%7BA549BEAA-044A-36B6-C635-188798168B17%7D.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/input-sources" = {
      mru-sources = [ (mkTuple [ "xkb" "us" ]) ];
      sources = [ (mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "default";
      enable-animations = true;
      show-battery-percentage = true;
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "code" "org-kde-kdeconnect-daemon" "qq" "vivaldi-stable" "org-gnome-nautilus" "org-telegram-desktop" "gnome-power-panel" "org-gnome-console" "arduino" "thunderbird" "wemeetapp" "gnome-network-panel" "fish" "org-gnome-shell-extensions" "clash-verge" "org-gnome-settings" "firefox" "element-desktop" "org-gnome-totem" "xdg-desktop-portal-gnome" "startcenter" "draw" "zotero" "discord" "android-studio" "org-gnome-eog" "org-gnome-extensions-desktop" "idea-community" "org-gnome-epiphany" ];
      show-banners = true;
    };

    "org/gnome/desktop/notifications/application/android-studio" = {
      application-id = "android-studio.desktop";
    };

    "org/gnome/desktop/notifications/application/arduino" = {
      application-id = "arduino.desktop";
    };

    "org/gnome/desktop/notifications/application/clash-verge" = {
      application-id = "clash-verge.desktop";
    };

    "org/gnome/desktop/notifications/application/code" = {
      application-id = "code.desktop";
    };

    "org/gnome/desktop/notifications/application/discord" = {
      application-id = "discord.desktop";
    };

    "org/gnome/desktop/notifications/application/draw" = {
      application-id = "draw.desktop";
    };

    "org/gnome/desktop/notifications/application/element-desktop" = {
      application-id = "element-desktop.desktop";
    };

    "org/gnome/desktop/notifications/application/firefox" = {
      application-id = "firefox.desktop";
    };

    "org/gnome/desktop/notifications/application/fish" = {
      application-id = "fish.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-network-panel" = {
      application-id = "gnome-network-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/idea-community" = {
      application-id = "idea-community.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-baobab" = {
      application-id = "org.gnome.baobab.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-characters" = {
      application-id = "org.gnome.Characters.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-console" = {
      application-id = "org.gnome.Console.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-eog" = {
      application-id = "org.gnome.eog.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-epiphany" = {
      application-id = "org.gnome.Epiphany.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-extensions-desktop" = {
      application-id = "org.gnome.Extensions.desktop.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-extensions" = {
      application-id = "org.gnome.Extensions.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-settings" = {
      application-id = "org.gnome.Settings.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-shell-extensions" = {
      application-id = "org.gnome.Shell.Extensions.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-totem" = {
      application-id = "org.gnome.Totem.desktop";
    };

    "org/gnome/desktop/notifications/application/org-kde-kdeconnect-daemon" = {
      application-id = "org.kde.kdeconnect.daemon.desktop";
    };

    "org/gnome/desktop/notifications/application/org-telegram-desktop" = {
      application-id = "org.telegram.desktop.desktop";
    };

    "org/gnome/desktop/notifications/application/qq" = {
      application-id = "qq.desktop";
    };

    "org/gnome/desktop/notifications/application/startcenter" = {
      application-id = "startcenter.desktop";
    };

    "org/gnome/desktop/notifications/application/thunderbird" = {
      application-id = "thunderbird.desktop";
    };

    "org/gnome/desktop/notifications/application/vivaldi-stable" = {
      application-id = "vivaldi-stable.desktop";
    };

    "org/gnome/desktop/notifications/application/wemeetapp" = {
      application-id = "wemeetapp.desktop";
    };

    "org/gnome/desktop/notifications/application/xdg-desktop-portal-gnome" = {
      application-id = "xdg-desktop-portal-gnome.desktop";
    };

    "org/gnome/desktop/notifications/application/zotero" = {
      application-id = "zotero.desktop";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      old-files-age = mkUint32 30;
      recent-files-max-age = -1;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/anillc/.local/share/backgrounds/2023-06-21-19-22-44-%7BA549BEAA-044A-36B6-C635-188798168B17%7D.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/search-providers" = {
      sort-order = [ "org.gnome.Contacts.desktop" "org.gnome.Documents.desktop" "org.gnome.Nautilus.desktop" ];
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 0;
    };

    "org/gnome/desktop/sound" = {
      event-sounds = true;
      theme-name = "__custom";
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [];
      switch-applications-backward = [];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };

    "org/gnome/epiphany" = {
      ask-for-default = false;
    };

    "org/gnome/epiphany/state" = {
      is-maximized = false;
      window-size = mkTuple [ 1024 768 ];
    };

    "org/gnome/evince" = {
      document-directory = "@ms 'file:///home/anillc/Downloads'";
    };

    "org/gnome/evince/default" = {
      window-ratio = mkTuple [ 0.657963 0.437548 ];
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/file-roller/listing" = {
      list-mode = "as-folder";
      name-column-width = 640;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/gnome/file-roller/ui" = {
      sidebar-width = 200;
      window-height = 721;
      window-width = 1280;
    };

    "org/gnome/gnome-system-monitor" = {
      current-tab = "disks";
      maximized = true;
      network-total-in-bits = false;
      show-dependencies = false;
      show-whose-processes = "user";
      window-state = mkTuple [ 800 1248 ];
    };

    "org/gnome/gnome-system-monitor/disktreenew" = {
      col-6-visible = true;
      col-6-width = 870;
    };

    "org/gnome/gnome-system-monitor/proctree" = {
      columns-order = [ 0 1 2 3 4 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 ];
      sort-col = 8;
      sort-order = 0;
    };

    "org/gnome/maps" = {
      last-viewed-location = [ 38.427021916443586 (-92.0331028097168) ];
      map-type = "MapsStreetSource";
      transportation-type = "pedestrian";
      window-maximized = true;
      zoom-level = 19;
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = true;
      focus-change-on-pointer-rest = true;
      workspaces-only-on-primary = false;
    };

    "org/gnome/nautilus/compression" = {
      default-compression-format = "zip";
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
      search-view = "list-view";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 960 768 ];
      maximized = false;
    };

    "org/gnome/nm-applet/eap/e854fe4d-b6c0-4e91-b191-aabde1e0c644" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/photos" = {
      window-maximized = true;
    };

    "org/gnome/portal/filechooser/org/telegram/desktop" = {
      last-folder-path = "/home/anillc/Documents/games/osu/Skins";
    };

    "org/gnome/portal/filechooser/vivaldi-stable" = {
      last-folder-path = "/home/anillc";
    };

    "org/gnome/power-manager" = {
      info-history-type = "charge";
      info-last-device = "/org/freedesktop/UPower/devices/battery_hid_0018o4858o121Ax0001_battery";
      info-stats-type = "discharge-accuracy";
    };

    "org/gnome/settings-daemon/peripherals/touchscreen" = {
      orientation-lock = true;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = false;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      power = [ "XF86PowerOff" ];
      power-static = [ "" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Alt>s";
      command = "share-file";
      name = "share-file";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      ambient-enabled = false;
      idle-dim = false;
      power-button-action = "suspend";
      power-saver-profile-on-low-battery = true;
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      app-picker-layout = "[{'org.gnome.Geary.desktop': <{'position': <0>}>, 'org.gnome.Contacts.desktop': <{'position': <1>}>, 'org.gnome.Weather.desktop': <{'position': <2>}>, 'org.gnome.clocks.desktop': <{'position': <3>}>, 'org.gnome.Maps.desktop': <{'position': <4>}>, 'org.gnome.Photos.desktop': <{'position': <5>}>, 'org.gnome.Totem.desktop': <{'position': <6>}>, 'android-studio.desktop': <{'position': <7>}>, 'org.gnome.Calculator.desktop': <{'position': <8>}>, 'arduino.desktop': <{'position': <9>}>, 'simple-scan.desktop': <{'position': <10>}>, 'org.gnome.Settings.desktop': <{'position': <11>}>, 'gnome-system-monitor.desktop': <{'position': <12>}>, 'discord.desktop': <{'position': <13>}>, 'Utilities': <{'position': <14>}>, 'element-desktop.desktop': <{'position': <15>}>, 'yelp.desktop': <{'position': <16>}>, 'org.gnome.Extensions.desktop': <{'position': <17>}>, 'org.gnome.Cheese.desktop': <{'position': <18>}>, 'org.fcitx.Fcitx5.desktop': <{'position': <19>}>, 'fcitx5-configtool.desktop': <{'position': <20>}>, 'org.fcitx.fcitx5-migrator.desktop': <{'position': <21>}>, 'firefox.desktop': <{'position': <22>}>, 'clash-verge.desktop': <{'position': <23>}>}, {'fish.desktop': <{'position': <0>}>, 'htop.desktop': <{'position': <1>}>, 'idea-community.desktop': <{'position': <2>}>, 'org.kde.kdeconnect.app.desktop': <{'position': <3>}>, 'org.kde.kdeconnect.nonplasma.desktop': <{'position': <4>}>, 'org.kde.kdeconnect-settings.desktop': <{'position': <5>}>, 'org.kde.kdeconnect.sms.desktop': <{'position': <6>}>, 'kbd-layout-viewer5.desktop': <{'position': <7>}>, 'kitty.desktop': <{'position': <14>}>, 'base.desktop': <{'position': <15>}>, 'calc.desktop': <{'position': <16>}>, 'draw.desktop': <{'position': <17>}>, 'impress.desktop': <{'position': <18>}>, 'math.desktop': <{'position': <19>}>, 'startcenter.desktop': <{'position': <20>}>, 'writer.desktop': <{'position': <21>}>, 'org.gnome.Nautilus.desktop': <{'position': <22>}>, 'org.gnome.Music.desktop': <{'position': <23>}>}, {'nixos-manual.desktop': <{'position': <1>}>, 'Proton Experimental.desktop': <{'position': <2>}>, 'qq.desktop': <{'position': <3>}>, 'scrcpy.desktop': <{'position': <4>}>, 'scrcpy-console.desktop': <{'position': <5>}>, 'org.telegram.desktop.desktop': <{'position': <8>}>, 'org.gnome.TextEditor.desktop': <{'position': <9>}>, 'thunderbird.desktop': <{'position': <10>}>, 'org.gnome.Tour.desktop': <{'position': <11>}>, 'code.desktop': <{'position': <12>}>, 'org.gnome.Epiphany.desktop': <{'position': <13>}>, 'wemeetapp.desktop': <{'position': <14>}>, 'wemeetapp-force-x11.desktop': <{'position': <15>}>, 'winetricks.desktop': <{'position': <16>}>, 'xterm.desktop': <{'position': <17>}>, 'org.gnome.Calendar.desktop': <{'position': <18>}>}]";
      command-history = [ "r" ];
      disable-user-extensions = false;
      disabled-extensions = [ "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "apps-menu@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "window-list@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "improvedosk@nick-shmyrev.dev" "screen-rotate@shyzus.github.io" "osktouchpad@francescocaracciolo.uno" "trayIconsReloaded@selfmade.pl" "topiconsfix@aleskva@devnullmail.com" "forge@jmmaranan.com" "blur-my-shell@aunetx" "tiling-assistant@leleat-on-github" "launch-new-instance@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "windowgestures@extension.amarullz.com" "kimpanel@kde.org" "swap-finger-gestures-3-4@icedman.github.com" "disable-gestures-2021@verycrazydog.gmail.com" "gjsosk@vishram1123.com" "appindicatorsupport@rgcjonas.gmail.com" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" ];
      favorite-apps = [ "org.gnome.Console.desktop" "vivaldi-stable.desktop" "bitwarden.desktop" "org.telegram.desktop.desktop" "thunderbird.desktop" "zotero.desktop" "com.github.xournalpp.xournalpp.desktop" "code.desktop" ];
      last-selected-power-profile = "performance";
      welcome-dialog-last-shown-version = "43.3";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/appindicator" = {
      icon-opacity = 243;
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      settings-version = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/forge" = {
      css-last-update = mkUint32 37;
      focus-border-toggle = false;
      tiling-mode-enabled = false;
    };

    "org/gnome/shell/extensions/forge/keybindings" = {
      con-split-horizontal = [ "<Super>z" ];
      con-split-layout-toggle = [ "<Super>g" ];
      con-split-vertical = [ "<Super>v" ];
      con-stacked-layout-toggle = [ "<Shift><Super>s" ];
      con-tabbed-layout-toggle = [ "<Shift><Super>t" ];
      con-tabbed-showtab-decoration-toggle = [ "<Control><Alt>y" ];
      focus-border-toggle = [ "<Super>x" ];
      prefs-tiling-toggle = [ "<Super>w" ];
      window-focus-down = [ "<Super>j" ];
      window-focus-left = [ "<Super>h" ];
      window-focus-right = [ "<Super>l" ];
      window-focus-up = [ "<Super>k" ];
      window-gap-size-decrease = [ "<Control><Super>minus" ];
      window-gap-size-increase = [ "<Control><Super>plus" ];
      window-move-down = [ "<Shift><Super>j" ];
      window-move-left = [ "<Shift><Super>h" ];
      window-move-right = [ "<Shift><Super>l" ];
      window-move-up = [ "<Shift><Super>k" ];
      window-resize-bottom-decrease = [ "<Shift><Control><Super>i" ];
      window-resize-bottom-increase = [ "<Control><Super>u" ];
      window-resize-left-decrease = [ "<Shift><Control><Super>o" ];
      window-resize-left-increase = [ "<Control><Super>y" ];
      window-resize-right-decrease = [ "<Shift><Control><Super>y" ];
      window-resize-right-increase = [ "<Control><Super>o" ];
      window-resize-top-decrease = [ "<Shift><Control><Super>u" ];
      window-resize-top-increase = [ "<Control><Super>i" ];
      window-snap-center = [ "<Control><Alt>c" ];
      window-snap-one-third-left = [ "<Control><Alt>d" ];
      window-snap-one-third-right = [ "<Control><Alt>g" ];
      window-snap-two-third-left = [ "<Control><Alt>e" ];
      window-snap-two-third-right = [ "<Control><Alt>t" ];
      window-swap-down = [ "<Control><Super>j" ];
      window-swap-last-active = [ "<Super>Return" ];
      window-swap-left = [ "<Control><Super>h" ];
      window-swap-right = [ "<Control><Super>l" ];
      window-swap-up = [ "<Control><Super>k" ];
      window-toggle-always-float = [ "<Shift><Super>c" ];
      window-toggle-float = [ "<Super>c" ];
      workspace-active-tile-toggle = [ "<Shift><Super>w" ];
    };

    "org/gnome/shell/extensions/tiling-assistant" = {
      active-window-hint-color = "rgb(53,132,228)";
      last-version-installed = 41;
    };

    "org/gnome/shell/extensions/trayIconsReloaded" = {
      applications = "[]";
      icon-size = 18;
      icons-limit = 4;
      position-weight = 0;
      tray-position = "left";
    };

    "org/gnome/shell/extensions/unlock-dialog-background" = {
      brightness = 0.85;
      picture-uri = "/home/anillc/Pictures/QQ\22270\29255\&20210725001759.jpg";
      picture-uri-dark = "/home/anillc/Pictures/QQ\22270\29255\&20210725001759.jpg";
      sigma = 50;
    };

    "org/gnome/shell/extensions/windowgestures" = {
      swipe3-down = 0;
      swipe3-left = 0;
      swipe3-right = 0;
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
      locations = [];
    };

    "org/gnome/shell/world-clocks" = {
      locations = [];
    };

    "org/gnome/simple-scan" = {
      document-type = "photo";
    };

    "org/gnome/software" = {
      check-timestamp = mkInt64 1693902695;
      first-run = false;
      flatpak-purge-timestamp = mkInt64 1693907989;
    };

    "org/gtk/gtk4/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 1.0 0.964706 ]) (mkTuple [ 0.705882 0.654902 ]) (mkTuple [ 0.968627 0.635294 ]) (mkTuple [ 6.6667e-2 0.780392 ]) (mkTuple [ 0.92549 0.368627 ]) ];
      selected-color = mkTuple [ true 1.0 ];
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 140;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "descending";
      type-format = "category";
      view-type = "list";
      window-size = mkTuple [ 859 374 ];
    };

    "org/gtk/settings/color-chooser" = {
      selected-color = mkTuple [ true 1.0 ];
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 170;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 26 23 ];
      window-size = mkTuple [ 800 721 ];
    };

    "system/locale" = {
      region = "en_US.UTF-8";
    };

    "system/proxy" = {
      ignore-hosts = [ "localhost" "127.0.0.1" "::1" ];
      mode = "none";
    };

    "system/proxy/http" = {
      host = "127.0.0.1";
      port = 7890;
    };

    "system/proxy/https" = {
      host = "127.0.0.1";
      port = 7890;
    };

    "system/proxy/socks" = {
      host = "127.0.0.1";
      port = 7890;
    };

  };
}
