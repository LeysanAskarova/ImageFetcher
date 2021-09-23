# frozen_string_literal: true

require_relative 'lib/downloader'
require_relative 'lib/link'

file_path = "./data/data.txt"
separator = $/

raise Errno::ENOENT, "No such file or directory (#{file_path})" unless File.exist?(file_path)
File.open(file_path) do |file|
  file.each_line(separator) do |line|
    link = Link.new(line.strip)
    link.validate

    unless link.errors.empty?
      puts link.errors
      next
    else
      Downloader.download(link.link)
    end
  end
  file.close
end
