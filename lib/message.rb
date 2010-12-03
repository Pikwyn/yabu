# I contain class methods that displays messages on the screen.
class Message

	# I print a little banner that state I'm a free software.
	def Message.printLicense
		license = <<END_OF_LICENSE
		
"Yeah! Another Backup Utility" Copyright (C) 2010 Xavier Nayrac
This program comes with ABSOLUTELY NO WARRANTY. This is free software, and you
are welcome to redistribute it under certain conditions.
See COPYING for license details.
    
END_OF_LICENSE
		puts license
	end

	# Call me when the hard work is over.	
	def Message.printEnd
		puts "Done."
	end
	
end
