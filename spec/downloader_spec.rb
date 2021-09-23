require 'rspec'
require_relative '../app/lib/downloader'

describe 'Downloader' do
  let(:file_path) { File.absolute_path('testimage.jpg', 'spec/data') }
  let(:file_path_check) { 'downloads/testimage.jpg' }

  after do
    File.delete(file_path_check) if File.exist?(file_path_check)
  end

  describe 'download file' do
    it 'image downloaded successfully' do
      Downloader.download(file_path)
      expect(File.exist?(file_path_check)).to be true
    end

    it 'image downloaded with error' do
      expect { Downloader.download('') }.to raise_error(Errno::ENOENT)
    end

    it 'image downloaded with error' do
      expect { Downloader.download('https://test/test.jpg') }.to raise_error(SocketError)
    end
  end
end
