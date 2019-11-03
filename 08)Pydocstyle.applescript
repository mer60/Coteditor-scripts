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

-- " 2>&1 &" redirect stderr to stdout
set lintMsg to do shell script "/Library/Frameworks/Python.framework/Versions/3.7/bin/pydocstyle " & quoted form of (theFile's POSIX path) & " | cut -d: -f2-4" & " 2>&1 &"
write to console lintMsg & "\n" & "************* done"