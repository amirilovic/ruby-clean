require_relative '../module'

describe App::Repositories::PhotoRepository do
  subject { described_class.new }

  let(:photo) { App::Entities::Photo.new({:original_file_name => original_file_name,
                                          :file_name => file_name,
                                          :width => width,
                                          :height => height,
                                          :format => format,
                                          :mime_type => mime_type,
                                          :user_id => user_id,
                                          :status => status,
                                          :file_size => file_size,
                                          :quality => quality
                                         }) }


  let(:original_file_name) { 'original_test.jpg' }
  let(:file_name) { 'test.jpg' }
  let(:width) { 200 }
  let(:height) { 200 }
  let(:format) { 'JPEG' }
  let(:mime_type) { 'image/jpeg' }
  let(:user_id) { 1 }
  let(:status) { 'ACTIVE' }
  let(:file_size) { 12345678 }
  let(:quality) { 90 }

  describe '#save' do
    it 'should save the photo' do
      subject.save(photo)
      expect(subject.count).to be 1
    end

    it 'should not save invalid photo' do
      photo.file_size = nil
      expect { subject.save(photo) }.to raise_error(ArgumentError)
    end
  end
end