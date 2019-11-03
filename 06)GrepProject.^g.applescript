-- show dialog if the document wasn't saved?
property showAlertDialog : true

-- get file path from CotEditor
tell application "CotEditor"
	if not (exists front document) then return

	set theFile to file of front document
end tell

-- end script if no file path is specified
if theFile is missing value then
	if showAlertDialog then
		display alert "No file path is specified." message "Please save the file first." as warning
		return
	end if

	return
end if

-- check for selected text
tell application "CotEditor"
	tell front document
		if (count of contents of selection) is 0 then return

		set query to contents of selection
	end tell
end tell

-- get directory path
set dirPath to do shell script "dirname " & quoted form of (theFile's POSIX path)
set actDir to quoted form of dirPath

-- show in console
set grpMsg to (do shell script "/usr/bin/grep -Hnirl --exclude-dir=.vcs --include=*.py " & query & " " & actDir & " | cut -d: -f1")
write to console grpMsg