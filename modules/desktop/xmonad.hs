import Control.Monad

import XMonad
import XMonad.Operations
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.TaffybarPagerHints
import XMonad.Layout.Spacing
import XMonad.Actions.SpawnOn
import XMonad.Actions.CycleWS
import Control.Monad.IO.Class
import qualified XMonad.StackSet as S

cfg = ewmh $ ewmhFullscreen $ docks $ bar $ pagerHints $ flip additionalKeysP
      ([ ("<XF86AudioMute>"        , spawn "amixer -q sset Master toggle")
      ,  ("<XF86AudioLowerVolume>" , spawn "amixer -q sset Master 5%-")
      ,  ("<XF86AudioRaiseVolume>" , spawn "amixer -q sset Master 5%+")
      ,  ("M-s"                    , spawn "flameshot gui")
      ,  ("M-p"                    , spawn "rofi -show run")
      ,  ("<XF86Calculater>"       , spawn "systemctl hibernate")
      ,  ("<XF86MyComputer>"       , spawn "dm-tool lock")
      ,  ("<XF86MonBrightnessUp>"  , spawn "xbacklight +15")
      ,  ("<XF86MonBrightnessDown>", spawn "xbacklight -15")
      ,  ("M-n"                    , nextScreen)
      ,  ("M-2"                    , liftIO $ return ()) -- noop
      ] ++
      [(if key /= 2 -- workspace keybindings
            then "M-" ++ show key
            else "M-0", windows $ S.greedyView name) | (key, name) <- zip [1..] ws
      ]) $ def
      { terminal        = "kitty"
      , workspaces      = ws
      , focusedBorderColor = "#AAAAAA"
      , normalBorderColor  = "#FFFFFF"
      , layoutHook      = spacingWithEdge 3 $ layoutHook def
      , manageHook      = manageHook  def <+> manageSpawn
      , startupHook     = startupHook def <+> start
      }

bar = flip withEasySB keyBinding $ statusBarProp "polybar" $ pure def
  where keyBinding XConfig { modMask = m } = (m, xK_b)

ws = ["1:main", "2", "3:chat", "4:pass", "5:media", "6:mail", "7", "8", "9"]

start = do
  spawnOn "3:chat" "telegram-desktop"
  spawnOn "3:chat" "kitty"
  spawnOn "4:pass" "bitwarden"
  spawnOn "6:mail" "thunderbird"

main = do
  spawnPipe "@feh@/bin/feh --bg-fill @bg@"
  spawnPipe "xmodmap -e 'keycode 86 = Home'"
  xmonad cfg
