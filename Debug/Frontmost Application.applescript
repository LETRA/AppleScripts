(*
-- Frontmost Application
-- View the properties of the frontmost application process
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
*)
property lib : load script (POSIX path of (path to scripts folder) & "lib/lib.scpt")

property application_process_properties : {�
	"accepts high level events", �
	"accepts remote events", �
	"accessibility description", �
	"application file", �
	"architecture", �
	"background only", �
	"bundle identifier", �
	"class", �
	"Classic", �
	"creator type", �
	"description", �
	"displayed name", �
	"enabled", �
	"entire contents", �
	"file", �
	"file type", �
	"focused", �
	"frontmost", �
	"has scripting terminology", �
	"help", �
	"id", �
	"maximum value", �
	"minimum value", �
	"name", �
	"orientation", �
	"partition space used", �
	"position", �
	"role", �
	"role description", �
	"selected", �
	"short name", �
	"size", �
	"subrole", �
	"title", �
	"total partition size", �
	"unix id", �
	"value", �
	"visible"}

on run argv
	set _process to frontmostApplicationProcess() of _UI of lib
	set output to probeApplicationProcess(_process)
	do shell script "echo " & quoted form of output & " | open -f"
end run

on probeApplicationProcess(_process)
	set _pad_length to 0
	repeat with _item in every item of application_process_properties
		if (count of _item) > _pad_length then set _pad_length to (count of _item)
	end repeat
	
	set output to ""
	tell application "System Events"
		set _process to first application process whose frontmost is true
		set p to properties of _process
		
		set l to {accepts high level events of p, accepts remote events of p, accessibility description of p, application file of p, architecture of p, background only of p, bundle identifier of p, class of p, Classic of p, creator type of p, description of p, displayed name of p, enabled of p, entire contents of p, file of p, file type of p, focused of p, frontmost of p, has scripting terminology of p, help of p, id of p, maximum value of p, minimum value of p, name of p, orientation of p, partition space used of p, position of p, role of p, role description of p, selected of p, short name of p, size of p, subrole of p, title of p, total partition size of p, unix id of p, value of p, visible of p}
		
		repeat with i from 1 to the (count of application_process_properties)
			set _key to item i of application_process_properties
			set _val to (item i of l)
			set _class to (class of _val as text)
			
			set _line to padRight(_key, " ", _pad_length) of _Text of lib & " : "
			
			if _val is missing value or _class is "boolean" or _class is "integer" or _class is "class" then
				set _line to _line & (_val as string)
			else if _class is "list" then
				set _line to _line & "{" & (_val as string) & "}"
			else if _class is "text" then
				set _line to _line & "\"" & (_val as string) & "\""
			else
				set _line to _line & _class & " \"" & (_val as string) & "\""
			end if
			
			set output to output & _line & linefeed
		end repeat
	end tell
	return output
end probeApplicationProcess