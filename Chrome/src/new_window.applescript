# This script is used to open a new Chrome window.
# If an argument is passed to the workflow it is
# treated as an URL or as a search term for a Google search.
on run argv
    if argv is not equal to {} then
		set theQuery to item 1 of argv
	else
		set theQuery to ""
	end if
	tell application "Google Chrome"
		make new window
		activate

		if theQuery is not equal to "" then
			if my url_exists(theQuery) then
				if {theQuery does not start with "http://"} then
					set theURL to "http://" & theQuery
				else
					set theURL to theQuery
				end if
			else
				set theURL to "http://www.google.com/#q=" & theQuery
			end if

			set URL of active tab of front window to theURL
		end if

	end tell
end run

on url_exists(checkURL)
	try
		set page to do shell script "curl -si " & quoted form of checkURL
		set responseCode to items 10 thru 12 of page as string

		if responseCode < 400 then
			return true
		end if

	on error theError
		return false
	end try
end url_exists
