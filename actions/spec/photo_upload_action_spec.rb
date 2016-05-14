require_relative '../../repositories/module'
require_relative '../module'

describe App::Actions::PhotoUploadAction do
  subject { described_class.new(photo_repository, user_repository, file_repository, image_utility) }

  let(:photo_repository) { App::Repositories::PhotoRepository.new }
  let(:user_repository) { instance_double('App::Repositories::UserRepository') }
  let(:file_repository) { App::Repositories::FileRepository.new }
  let(:image_utility) { instance_double('App::Utilities::ImageUtility') }

  let(:params) { {:user_id => user_id, :file_path => file_path} }

  let(:user_id) { 1 }
  let(:file_path) { 'temp/test.jpg' }

  let(:user) { App::Entities::User.new(:email => email, :name => name, :password => password, :status => status) }

  let(:email) { 'pera@pera.com' }
  let(:name) { 'Pera Peric' }
  let(:password) { '12345678' }
  let(:status) { 'ACTIVE' }

  let(:photo_info) {
    PhotoInfo = Struct.new(:format, :mime_type, :width, :height, :quality, :file_size, :file_name)
    PhotoInfo.new(format, mime_type, width, height, quality, file_size, file_name)
  }

  let(:format) { 'JPEG' }
  let(:mime_type) { 'image/jpeg' }
  let(:width) { 200 }
  let(:height) { 200 }
  let(:quality) { 90 }
  let(:file_size) { 2000 }
  let(:file_name) { 'test.jpg' }


  describe '#call' do
    it 'should upload new photo' do
      expect(image_utility).to receive(:info).with(file_path) { photo_info }
      expect(user_repository).to receive(:find).with(user_id) { user }

      response = subject.call(params)

      expect(response.success).to be true
      expect(response.data).to be_a App::Entities::Photo
      expect(response.data.id).not_to be_nil
      expect(response.data.format).to be format
      expect(response.data.mime_type).to be mime_type
      expect(response.data.width).to be width
      expect(response.data.height).to be height
      expect(response.data.quality).to be quality
      expect(response.data.file_size).to be file_size
      expect(response.data.original_file_name).to be file_name
      expect(response.data.file_name).not_to be_empty
      expect(response.errors).to be_empty
    end

    it 'should validate required params' do
      expect { subject.call({}) }.to raise_error(ArgumentError)
      expect { subject.call({:user_id => user_id}) }.to raise_error(ArgumentError)
      expect { subject.call({:file_path => file_path}) }.to raise_error(ArgumentError)
    end

    it 'should validate if user exists' do
      expect(user_repository).to receive(:find).with(user_id).and_raise(App::Repositories::RecordNotFoundError)
      expect { subject.call(params) }.to raise_error(App::Repositories::RecordNotFoundError)
    end
  end
end