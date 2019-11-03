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

-- show in console
set docMsg to do shell script "/Library/Frameworks/Python.framework/Versions/3.7/bin/pydoc3 " & query
write to console docMsg