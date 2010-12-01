require "fileutils"

# I'm doing the hard work of copying recursivly the files and directories to backup.
# I'm hacked from an article found on http://iamneato.com/2009/07/28/copy-folders-recursively
class Copier

	# @param [Array<String>] excludeFileList List of directories and files 
	#		to exclude from the backups.
  def initialize(excludeFileList)
  	@log = Log.getInstance
    @exclude = excludeFileList
  end

	# I try to recursively copy src to dest.
	# @param [String] src the source file or directory
	# @param [String] dest the destination directory
  def copy src, dest
    createIfNeeded dest
    if not File.directory? src
    	begin
				FileUtils.cp(src, dest)
			rescue
				@log.fatal "Cannot copy #{src} to #{dest}"
			end
			@log.info "Copied #{src} to #{dest}"
    	return
    end
    
    begin
			Dir.foreach(src) do |file|
				if exclude?(File.join(src, file))
					@log.info("Exclude from saving : " + File.join(src, file))
					next
				end
				next if file == "."
				next if file == ".."
				s = File.join(src, file)
				d = File.join(dest, file)
				if File.directory?(s)
					begin
						FileUtils.mkdir(d)
					rescue SystemCallError
						@log.fatal "Cannot create directory #{d}"
					end
					@log.info "Created " + d
					copy s, d
				else
					begin
						FileUtils.cp(s, d)
					rescue
						@log.fatal "Cannot copy #{s} to #{d}"
					end
					@log.info "Copied #{s} to #{d}"
				end
			end
    rescue SystemCallError
    	@log.error "Cannot read #{src}"
    end
  end

private

  def createIfNeeded dest
    if not File.exist?(dest)
			begin
				FileUtils.makedirs dest
			rescue SystemCallError
				@log.fatal "Cannot create #{dest}"
			end
			@log.info "Created #{dest}"
		end
  end

  def exclude? file
    @exclude.each do |s|
      if file.match(/#{s}/)
        return true
      end
    end
    false
  end
end