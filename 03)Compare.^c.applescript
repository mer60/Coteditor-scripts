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

-- get directory path
set dirPath to do shell script "dirname " & quoted form of (theFile's POSIX path)

set actFile to theFile's POSIX path

-- select file to compare, if none is choosen return
try
    set tmpFile to (choose file with prompt "Select File to Compare with " & actFile default location dirPath with invisibles)
    on error
    display notification "Diff aborted"
    return
end try

set oldFile to tmpFile's POSIX path

-- do shell script "opendiff " & oldFile & " " & actFile & " " & "-merge " & actFile & ".merge"

-- open in terminal
tell application "Terminal"
	do script "diff -bBuw " & oldFile & " " & actFile & " | ydiff" in window 1
	activate
end tell