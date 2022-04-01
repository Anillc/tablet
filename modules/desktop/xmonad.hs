import Control.Monad

import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Spacing
import XMonad.Layout.IndependentScreens
import XMonad.Actions.SpawnOn

cfg = ewmh $ ewmhFullscreen $ bar $ flip additionalKeysP
      [ ("<XF86AudioMute>"       , spawn "amixer -q sset Master toggle")
      , ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 2%-")
      , ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 2%+")
      , ("M-s"                   , spawn "flameshot gui")
      ] $ def
      { terminal        = "kitty"
      , workspaces      = (withScreens 1 ["1", "2", "3", "4", "5", "6", "7", "8", "9"]) ++ (withScreens 2 ["aa"])
      , focusedBorderColor = "#AAAAAA"
      , normalBorderColor = "#FFFFFF"
      , layoutHook      = spacingWithEdge 3 $ layoutHook defaultConfig
      , handleEventHook = fullscreenEventHook <+> handleEventHook defaultConfig
      , manageHook      = manageSpawn         <+> manageHook defaultConfig
--      , startupHook     = start               <+> startupHook defaultConfig
      }

bar = flip withEasySB keyBinding $ statusBarProp "xmobar" $ pure xmobarPP
  where keyBinding XConfig { modMask = m } = (m, xK_b)

start = spawnOn "3" "keepassxc"

main = spawnPipe "@feh@/bin/feh --bg-fill @bg@" >> spawnPipe "xmobar" >> xmonad cfg
