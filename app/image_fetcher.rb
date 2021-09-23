# frozen_string_literal: true

require_relative 'lib/downloader'
require_relative 'lib/link'

file_path = "./data/data.txt"
separator = $/

raise Errno::ENOENT, "No such file or directory (#{file_path})" unless File.exist?(file_path)
File.open(file_path) do |file|
  file.each_line(separator) do |line|
    file_path = Link.new(line.strip)
    file_path.validate

    unless file_path.errors.empty?
      puts file_path.errors
      next
    else
      Downloader.download(file_path.link)
    end
  end
  file.close
end
