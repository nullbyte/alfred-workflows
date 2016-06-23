# This script is used to detect the topmost Finder window
# and cd into it from an iTerm session.
# If iTerm is running it opens a new tab.
tell application "Finder"
	set numberOfFinderWindows to count Finder windows
	if (numberOfFinderWindows > 0) then
		set theTopmostFinderWindow to get POSIX path of (target of window 1 as alias)
	else
		set theTopmostFinderWindow to get POSIX path of (desktop as alias)
	end if
end tell

if application "iTerm" is running then
	tell application "iTerm"
		set theTopmostiTermWindow to count windows
		
		if (theTopmostiTermWindow > 0) then
			tell window theTopmostiTermWindow to create tab with default profile
		else
			create window with default profile
		end if
		
		tell current window to tell current session to write text "cd " & theTopmostFinderWindow
	end tell
else
	tell application "Applications:iTerm.app"
		activate
		tell current session of first window to write text "cd " & theTopmostFinderWindow
	end tell
end if
