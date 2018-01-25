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
import XMonad.Util.SpawnOnce
import XMonad.Config.Kde

myLayoutHook            = onWorkspace "1:term" (tall ||| Mirror tall ||| Full) 
                        $ onWorkspace "5:wine" Full          
                        $ (Full ||| tall ||| Mirror tall) 
                                where 
                                    tall = Tall 1 0.02 0.7 
myManageHook = composeAll . concat $
    [ [ className =? c --> doFloat                    | c <- myFloats ]
    , [ className =? c --> doIgnore                   | c <- myIgnores ]
    , [ className =? c --> doF (W.shift "1:term")     | c <- myTerminals ]
    , [ className =? c --> doF (W.shift "2:www")      | c <- myWebBrowsers ]
    , [ className =? c --> doF (W.shift "3:media")    | c <- myMediaEditors ]
    , [ className =? c --> doF (W.shift "4:PIM")      | c <- myPIMManagers ]
    , [ className =? c --> doF (W.shift "5:games")    | c <- myGames ]
    , [ className =? c --> doF (W.shift "9:torrent")  | c <- myTorrents ]
    ]
    where 
        myFloats        = ["Vlc", "Gimp", "Prompt", "Overjanje", "ark", "Wine", "ksysguard", "Yakuake"]
        myTerminals     = ["URxvt", "Konsole"]
        myWebBrowsers   = ["Chromium","Firefox"]
        myMediaEditors  = ["Gimp", "Inkscape"] 
        myPIMManagers   = ["Thunderbird"] 
        myGames         = ["Wine", "Steam"] 
        myTorrents      = ["qBittorrent"] 
        myIgnores       = ["Yakuake"] 



-- myLogHook               = return ()

myStartupHook           = do
    setDefaultCursor xC_left_ptr
    spawnOnce "~/bin/clearScreen.sh"
    spawnOnce "xcompmgr -f"
    spawnOnce "urxvt"
    spawnOnce "firefox"
    spawnOnce "feh --randomize --bg-fill ~/ozadja/"
    

	
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
         , ("M-s", spawn "conky -c /home/imnos/.conky/Gotham/Gotham |  dzen2 -p 4")
         , ("M-e", spawn "urxvt -e ranger")
         , ("M-<Escape>", spawn "ksysguard")
	 , ("M-d", date)	
	 , ("M-<Print>", spawn "scrot -q 1 $HOME/slike/screenshots/%Y-%m-%d-%H:%M:%S.png > /home/imnos/errors.log 2>&1")
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
        ,workspaces          = ["1:term", "2:www", "3:media", "4:PIM", "5:wine"] ++ map show [6..8] ++ ["9:torrent"]
--    ,mouseBindings       = myMouseBindings
        ,layoutHook          = myLayoutHook
        ,manageHook          = manageHook kdeConfig <+> myManageHook
        ,handleEventHook     = myEventHook <+> docksEventHook
--    ,logHook             = myLogHook
--    ,startupHook         = setDefaultCursor xC_left_ptr
        ,startupHook	   = myStartupHook
    }`additionalKeysP` myKeys
