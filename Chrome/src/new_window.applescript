# This script is used to open a new Chrome window.
# If an argument is passed to the workflow it is
# treated as an URL or as a search term for a Google search
on run argv
	set theQuery to item 1 of argv
	tell application "Google Chrome"
		make new window
		activate

		if theQuery is not equal to "" then
			if {theQuery starts with "http://"} then
				set theURL to theQuery
			else
				set theURL to "http://www.google.com/#q=" & theQuery
			end if

			set URL of active tab of front window to theURL
		end if
	end tell
end run
