import Control.Monad

import XMonad
import XMonad.Operations
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Spacing
import XMonad.Actions.SpawnOn
import XMonad.Actions.CycleWS
import qualified XMonad.StackSet as S

cfg = ewmh $ ewmhFullscreen $ bar $ flip additionalKeysP
      ([ ("<XF86AudioMute>"      , spawn "amixer -q sset Master toggle")
      , ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 2%-")
      , ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 2%+")
      , ("M-s"                   , spawn "flameshot gui")
      , ("M-n"                   , nextScreen)
      , ("M-2"                   , spawn "true") -- noop
      ] ++
      [(if key /= 2 -- workspace keybindings
            then "M-" ++ show key
            else "M-0", windows $ S.greedyView name) | (key, name) <- zip [1..] ws
      ]) $ def
      { terminal        = "kitty"
      , workspaces      = ws
      , focusedBorderColor = "#AAAAAA"
      , normalBorderColor = "#FFFFFF"
      , layoutHook      = spacingWithEdge 3 $ layoutHook defaultConfig
      , handleEventHook = fullscreenEventHook <+> handleEventHook defaultConfig
      , manageHook      = manageSpawn         <+> manageHook defaultConfig
      , startupHook     = start               <+> startupHook defaultConfig
      }

bar = flip withEasySB keyBinding $ statusBarProp "xmobar" $ pure xmobarPP
  where keyBinding XConfig { modMask = m } = (m, xK_b)

ws = ["1:main", "2", "3:chat", "4:pass", "5", "6", "7", "8", "9"]

start = spawnOn "4:pass" "keepassxc"

main = spawnPipe "@feh@/bin/feh --bg-fill @bg@" >> spawnPipe "xmobar" >> xmonad cfg
