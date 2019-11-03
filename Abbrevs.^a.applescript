-- list all abbreviations to console

-- check for opened document
tell application "CotEditor"
	if not (exists front document) then return

end tell

-- defined snippets
set snippets to "
    C-0     shebang
    C-1     breakpoint()  # TODO remove breakpoint
    C-2     # noqa
    C-3     # TODO
    C-4     class Application(cmd.Cmd)
                "

-- show in console
write to console snippets