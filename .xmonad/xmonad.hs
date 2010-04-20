import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W
import System.IO
import Data.Monoid


myManageHook = composeOne [ isFullscreen -?> doFullFloat ]

myManageHook2 = composeAll
		[ 
                 className =? "Amarok" --> doShift "5:music"
		]

fullFloatFocused = withFocused $ \f -> windows =<< appEndo `fmap` runQuery
		   doFullFloat f

myWorkspaces = ["1:web","2:work","3:work","4:work","5:music","6:stuff","7:stuff","8:stuff","9:stuff"]

myKeys = [ 
         ((mod4Mask .|. shiftMask,	xK_z)	, spawn "xscreensaver-command -lock")
       , ((controlMask, xK_Print)  	  	, spawn "sleep 0.2; scrot -s")
       , ((mod4Mask,			xK_Print) , spawn "scrot -d 3")    
       , ((mod4Mask .|. shiftMask, 	xK_Home), fullFloatFocused) 
       , ((mod4Mask, 	   		xK_p)  	, spawn "exe=`dmenu_path | dmenu -nb wheat -nf darkslategray -sb darkslategray -sf wheat` && eval \"exec $exe\"")
       , ((mod4Mask .|. shiftMask,	xK_p)	, spawn "exe=`dmenu_path | dmenu -nb wheat -nf darkslategray -sb darkslategray -sf wheat` && eval \"exec urxvt -e $exe\"")       
	]
        ++
        [ ((m .|. mod4Mask, k), windows $ f i) 
              | (i, k) <- zip myWorkspaces [xK_1 .. xK_9]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
        ]


main = do
    xmproc <- spawnPipe "xmobar /home/askr/.xmobarrc"
    xmonad $ defaultConfig
        { workspaces = myWorkspaces
	, terminal  = "urxvt"
	, manageHook = manageDocks <+> myManageHook <+> myManageHook2 <+> manageHook defaultConfig
        , layoutHook = smartBorders $ avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#CDBA96" "" . shorten 100
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys` myKeys

