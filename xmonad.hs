import XMonad
import XMonad.Util.Run
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig
import XMonad.Layout
import XMonad.Layout.IM
import XMonad.Layout.Named
import XMonad.Layout.Tabbed
import XMonad.Layout.Spacing
import XMonad.Layout.HintedGrid
import XMonad.Layout.Magnifier
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns
import XMonad.Layout.DragPane
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks

-- XMonad Setup
main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig{
                        terminal    = terminalSetting,
                        startupHook = startupSetting,
                        layoutHook = toggleLayouts (noBorders Full) $ avoidStruts $ myLayout
                        }
                        `additionalKeysP`
                        shortcutSetings
                        `additionalKeys`
                        [
                        ((0                       , 0x1008ff13), spawn "amixer set Master 5%+ && aplay /opt/mikutter/core/skin/data/sounds/mikuxtu-se.wav") --require mikutter
                        , ((0                       , 0x1008ff11), spawn "amixer set Master 5%- && aplay /opt/mikutter/core/skin/data/sounds/mikuxtu-se.wav") --require mikutter
                        , ((0                       , 0x1008ff12), spawn "amixer Master toggle")
                        ]

-- leyout(Copy from internet)
myLayout = (spacing 2 $ Grid False) ||| Full ||| (spacing 2 $ ResizableTall 1 (3/100) (1/2) []) ||| (spacing 2 $ ThreeColMid 2 (3/100) (1/2))

-- MyShortcutKeys
shortcutSetings = [("M1-l",spawn "xscreensaver-command -lock"),
                  ("C-S-4",spawn "gnome-screenshot --area"),
                  ("M1-C-p",spawn "xrandr-out"),
                  ("M1-C-r",spawn "xrandr-in"),
                  ("M1-C-w",spawn "xrandr-d-left"),
                  ("M1-C-q",spawn "xrandr-d-right")
                  ]
-- default terminal app
terminalSetting = "gnome-terminal"

-- startup command
startupSetting = do
    spawn "/usr/bin/xscreensaver -no-splash &"
    spawn "stalonetray -i 1 --geometry 6x1-510 -bg black &"
    spawn "xmodmap ~/.Xmodmap"
    spawn "nitrogen --restore"
    spawn "amixer set Master 0"
    spawn "pulseaudio --start"
    spawn "alsactl restore"
    spawn "owncloud"
    spawn "xautolock -time 1 -locker 'xscreensaver-command -lock' &"
    setWMName "LG3D"

