(*
-- Reset Window
-- Restore custom layout settings of finder windows
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"
property _Finder : include("Application/Finder") of lib

on run argv
	my process(argv)
end run

on open argv
	my process(argv)
end open

on process(argv)
	tell application "Finder"
		try
			set _win to the front Finder window
		on error
			return false
		end try
		
		set _settings to {current view:missing value �
			, zoomed:true �
			, sidebar width:136 �
			, statusbar visible:true �
			, toolbar visible:true �
			, list view options:{calculates folder sizes:false, shows icon preview:true, icon size:small, text size:11, uses relative dates:true} �
			, column view options:{text size:11, shows icon:true, shows icon preview:true, shows preview column:true, discloses preview pane:true} �
			, icon view options:{arrangement:arranged by name, icon size:72, shows item info:false, shows icon preview:true, text size:11, label position:bottom} �
			}
		
		if (sidebar width of _win as number) < 1 then set (sidebar width of _settings) to missing value
		if (toolbar visible of _win) = false then set (toolbar visible of _settings) to missing value
		
		setProperties(_win, _settings) of _window of _Finder
	end tell
end process