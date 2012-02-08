(*
-- Change Icon
-- Change the icon of selected Finder items
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property _bin : missing value

on run argv
	my process(argv)
end run

on open argv
	my process(argv)
end open

on process(argv)
	if class of argv is list then
		set _files to argv
	else
		tell application "Finder" to set _files to selection as alias list
	end if
	if (count of _files) is less than 1 then return
	
	if _bin is missing value then
		try
			set _bin to do shell script "bash -lc 'which seticon'"
		end try
		
		if _bin is missing value or _bin is "" then
			display alert "Error" message "seticon not found" as warning buttons {"OK"} default button 1
			return
		end if
		
		set _bin to quoted form of _bin
	end if
	
	set _icon to choose file
	set _icon_path to (quoted form of POSIX path of _icon)
	
	set _flags to ""
	tell application "Finder"
		if (name extension of _icon) is "icns" then set _flags to " -d"
	end tell
	
	set _pathnames to ""
	repeat with i in _files
		set _File to i as alias
		do shell script _bin & _flags & " " & _icon_path & " " & (quoted form of POSIX path of (_File as string))
	end repeat
	
end process