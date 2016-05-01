require_relative '../../repositories/module'
require_relative '../module'

describe App::Actions::PhotoViewAction do
  subject { described_class.new(photo_repository) }

  let(:photo_repository) { instance_double('App::Repositories::PhotoRepository') }

  let(:params) { {:photo_id => photo_id} }

  let(:photo_id) { 1 }

  let(:photo) { App::Entities::Photo.new({:id => photo_id,
                                          :original_file_name => original_file_name,
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

  describe '#call' do
    it 'should retrieve photo' do
      expect(photo_repository).to receive(:find).with(photo_id) { photo }

      response = subject.call(params)

      expect(response.success).to be true
      expect(response.data).to be_a App::Entities::Photo
      expect(response.data.id).to be photo_id
      expect(response.errors).to be_empty
    end

    it 'should validate required params' do
      expect { subject.call({}) }.to raise_error(ArgumentError)
    end
  end
end