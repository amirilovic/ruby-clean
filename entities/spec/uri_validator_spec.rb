require_relative '../validators/uri_validator'

describe UriValidator do
  subject { UriValidator.new({:attributes => [:uri]}) }

  describe '#uri?' do
    it 'should be valid uri' do
      subject.uri?('http://test.com')
    end

    it 'should be valid uri https schema' do
      subject.uri?('https://test.com')
    end

    it 'should be invalid uri without schema' do
      subject.uri?('test.com')
    end

    it 'should be invalid uri random string' do
      subject.uri?('fdffgfghheertrf')
    end

    it 'should be invalid uri integer' do
      subject.uri?(1)
    end

    it 'should be invalid uri nil' do
      subject.uri?(nil)
    end

  end

end
