
require 'optparse'

# I parse the command line.
# Currently, there's only options that display messages and exit. So you can instanciate me before
# dealing with class Backup and the like.
# @example
#		opt = Options.new # Exit if there are an option
#		bk = Backup.new # But do this if there are not.
class Options

	# Here is a list of command line options :
	# * version
	# * license
	# * help
	# @todo refactoring
	def initialize
		options = {}
		optparse = OptionParser.new do|opts|
		 	opts.banner = "Usage: ./saving.rb [options]"
		 	# Define the options, and what they do
   		options[:version] = false
   		opts.on( '-v', '--version', 'Print version number and exit' ) do
     		options[:version] = true
   		end
   		options[:license] = false
   		opts.on( '-l', '--license', 'Print program\'s license and exit' ) do
     		options[:license] = true
   		end
   		opts.on( '-h', '--help', 'Display this screen' ) do
     		puts opts
     		exit
   		end
		end
		optparse.parse!
		printVersion if options[:version]
		printLicense if options[:license]
	end
	
private

	def printVersion
		puts Version.get
		exit
	end
	
	def printLicense
		puts "\"Yeah! Another Backup Utility\" is licensed under the GPL 3. See the COPYING's file."
		exit
	end
end
