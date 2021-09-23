# frozen_string_literal: true

require 'net/http'
require 'open-uri'

# service for file downloading
class Downloader

  DOWNLOAD_ERRORS = [
    SocketError,          # domain not found
    OpenURI::HTTPError,   # response status 4xx or 5xx
    RuntimeError,         # redirection errors (e.g. redirection loop)
    URI::InvalidURIError, # invalid URL
    Errno::ENOENT         # no file or directory
  ].freeze

  def self.generate_name(link = '')
    link[link.rindex('/') + 1..-1]
  end

  def self.download(link = '', path_to = '../ImageFetcher/downloads/')
    begin
      read_file = open(link).read
      File.open("#{path_to}#{generate_name(link)}", 'wb') do |file|
        file.write read_file
      end
    rescue *DOWNLOAD_ERRORS => error
      raise error.class, "Download failed (#{link}): #{error.message}"
    end
  end
end
