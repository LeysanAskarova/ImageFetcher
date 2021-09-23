# frozen_string_literal: true

require 'net/http'
require 'open-uri'
require 'uri'
require_relative 'image'

# service for working with URL
class Link
  attr_reader :errors, :link

  def initialize(link)
    @link = link
    @errors = []
  end

  DOWNLOAD_ERRORS = [
    SocketError,          # domain not found
    OpenURI::HTTPError,   # response status 4xx or 5xx
    URI::InvalidURIError, # invalid url
    RuntimeError,         # redirection errors (e.g. redirection loop)
    ArgumentError         # empty url
  ].freeze

  def validate
    if self.check_url == true
      response = self.make_request
      check_response(response) if response
    end
  end

  def make_request
    begin
      url = URI.parse(@link)
      response = Net::HTTP.get_response(url)
    rescue *DOWNLOAD_ERRORS
      errors << "#{@link} URL is not available"
      false
    else
      response
    end
  end

  def check_url
    uri = URI.parse(@link.gsub(/\s+/, ""))
    if uri.is_a?(URI::HTTP) && !uri.host.nil?
      true
    else
      errors << "#{@link} is not an URL"
      false
    end
  end

  def check_response(response)
    case
    when response.content_length.to_i <= 0
      errors << "#{@link} File is empty"
    when response.content_length.to_i > Image::MAX_LIMIT
      errors << "#{@link} File is not downloaded. Max available size is #{Image::MAX_LIMIT_MB} MB "
    when Image::ALLOWED_TYPES.include?(response.content_type) == false
      errors << "#{@link} File with incorrect extension"
    end
  end
end
