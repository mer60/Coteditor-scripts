-- insert actaul date + 'Version' after the current line
property format : "\n# %Y-%m-%d\n# Version "

-- check for opened document
tell application "CotEditor"
	if not (exists front document) then return

	tell front document
		set contents of selection to (do shell script "date " & quoted form of ("+" & format))
	end tell
end tell