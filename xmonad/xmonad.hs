import XMonad
import XMonad.Layout.PerWorkspace
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W
import Control.Monad (liftM2)
import XMonad.Util.Cursor
-- added: dec 2013
import XMonad.Layout.Spacing
import XMonad.Actions.SimpleDate
import XMonad.Hooks.ScreenCorners
import XMonad.Actions.CycleWS
import XMonad.Hooks.ManageDocks
--import XMonad.Hooks.Urgencyhook
--import XMonad.Util.NamedWindows
--import XMonad.Util.Run


myLayoutHook            = onWorkspace "1:term" (tall ||| Mirror tall ||| Full) 
                        $ onWorkspace "5:wine" Full          
                        $ (Full ||| tall ||| Mirror tall) 
                                where 
                                    tall = Tall 1 0.02 0.7 
myManageHook = composeAll 
    [ className =? "Chromium" --> doShift "2:www"
    , className =? "URxvt" --> doShift "1:term"
    , className =? "Vlc" --> doFloat
    , className =? "Firefox" --> doShift "2:www"
    , className =? "Thunderbird" --> doShift "4:e-mail"
    , className =? "Xmessage" --> doFloat
    , className =? "Wine" --> doShift "5:wine"
    , className =? "Qbittorrent" --> doFloat
    , className =? "Gimp" --> doFloat 
    , className =? "Wpa_gui" --> doFloat
    , className =? "Tilda" --> doFloat
    , class =? "conky" --> doIgnore
    , className =? "MacSlow Cairo Ura" --> doFloat
    ]
-- myLogHook               = return ()

myStartupHook           = do
    addScreenCorners [ (SCLowerRight, nextWS)
                      ,(SCLowerLeft,  prevWS)
		      ,(SCUpperRight, spawn "cairo-clock") 	
                     ]
    setDefaultCursor xC_left_ptr

	
myEventHook e 		= do
    screenCornerEventHook e	
--data LibNotifyUrgenyHok = LibNotifyUrgencyHook deriving (Read, Show)

--instance UrgencyHook LibNotifyUrgencyHook where
--	urgencyHook LibNotifyUrgencyHook w = do
--	name	<- getName w
--	Just idx <- fmap (W.findTag w) $ gets windowset
--
--	safeSpawn "notify-send" [show name, "workspace " ++ idx]


myKeys = [ ("M-m", spawn "date +'%c' |  dzen2 -p 4")
         , ("M-s", spawnPipe "conky -c /home/imnos/.conky/Gotham/Gotham |  dzen2 -p 4")
         , ("M-e", spawn "urxvt -e ranger")
	 , ("M-d", date)	
	 , ("<XF86AudioMute>", spawn "~/.xmonad/bin/muteToggle")
	 , ("<XF86AudioLowerVolume>", spawn "~/.xmonad/bin/volDown")
	 , ("<XF86AudioRaiseVolume>", spawn "~/.xmonad/bin/volUp")
	 , ("<XF86AudioNext>", spawn "ncmpcpp next"   >> return())
	 , ("<XF86AudioPrev>", spawn "ncmpcpp prev"   >> return())
	 , ("<XF86AudioPlay>", spawn "ncmpcpp toggle" >> return())
	 , ("<XF86AudioStop>", spawn "ncmpcpp stop"   >> return())
	 ]	

main =  xmonad $ defaultConfig 
    {   terminal             = "urxvt"
        ,borderWidth         = 0
        ,focusFollowsMouse   = True
        ,modMask             = mod4Mask
        ,workspaces          = ["1:term", "2:www", "3:media", "4:e-mail", "5:wine"] ++ map show [6..8] ++ ["9:torrent"]
--    ,mouseBindings       = myMouseBindings
        ,layoutHook          = myLayoutHook
        ,manageHook          = myManageHook
        ,handleEventHook     = myEventHook <+> docksEventHook
--    ,logHook             = myLogHook
--    ,startupHook         = setDefaultCursor xC_left_ptr
        ,startupHook	   = myStartupHook
    }`additionalKeysP` myKeys
