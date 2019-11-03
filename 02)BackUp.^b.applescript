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

-- get filename
set fileName to do shell script "basename " & quoted form of (theFile's POSIX path)

-- make backup
do shell script "cp " & quoted form of (theFile's POSIX path) & " " & quoted form of (theFile's POSIX path) & "~"
display notification "Backup for " & quoted form of (fileName's POSIX path) & " done ..."