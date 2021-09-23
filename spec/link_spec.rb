require 'rspec'
require 'open-uri'
require_relative '../app/lib/link'

describe 'Link' do
  let(:correct_url) { 'https://test/test.jpg' }
  let(:incorrect_url) { 'test/test.jpg' }
  let(:correct_link) { Link.new(correct_url) }
  let(:incorrect_link) { Link.new(incorrect_url) }

  describe 'check line is url or not' do
    it 'line is url' do
      expect(correct_link.check_url).to be true
    end

    it 'line is not an url' do
      expect(incorrect_link.check_url).to be false
    end

    it 'line that not an url return errors' do
      incorrect_link.check_url
      expect(incorrect_link.errors).to_not be_empty
    end
  end

  describe 'check url availability' do
    it 'url is unavailable' do
      expect(correct_link.make_request).to be false
    end
  end
end
