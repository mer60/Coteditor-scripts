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

-- get args
display dialog "run [with *args] : " buttons {"Run", "ESC"} default button "Run" default answer ""

if button returned of result = "Run" then
    set theArgs to the text returned of result
    set theApp to "python3 "
else if button returned of result = "ESC" then
    return
end if

-- run in terminal
tell application "Terminal"
	do script theApp & quoted form of (theFile's POSIX path) & " " & theArgs in window 1
	activate
end tell