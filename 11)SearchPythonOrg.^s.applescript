-- check for opened document
tell application "CotEditor"
	if not (exists front document) then return

end tell

-- check for selected text
tell application "CotEditor"
	tell front document
		if (count of contents of selection) is 0 then return

		set query to contents of selection
	end tell
end tell

-- open in Safari
do shell script "open https://docs.python.org/3.7/search.html?q=" & query