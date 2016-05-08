require_relative '../../repositories/module'
require_relative '../module'

describe App::Actions::AlbumAddPhotoAction do
  subject { described_class.new(album_repository, photo_repository, user_repository) }

  let(:user_repository) { instance_double('App::Repositories::UserRepository') }
  let(:photo_repository) { instance_double('App::Repositories::PhotoRepository') }
  let(:album_repository) { instance_double('App::Repositories::AlbumRepository') }

  let(:params) { {:user_id => user_id, :photo_id => photo_id, :album_id => album_id} }

  let(:user_id) { 1 }
  let(:photo_id) { 1 }
  let(:album_id) { 1 }

  let(:user) { App::Entities::User.new(:id => user_id, :email => user_email, :name => user_name, :password => user_password, :status => user_status) }
  let(:album) { App::Entities::Album.new({:name => album_name, :user_id => user_id, :status => album_status}) }

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

  let(:user_email) { 'pera@pera.com' }
  let(:user_name) { 'Pera Peric' }
  let(:user_password) { '12345678' }
  let(:user_status) { 'ACTIVE' }

  let(:album_name) { 'The Best Album in the World!' }
  let(:album_status) { 'ACTIVE' }

  let(:original_file_name) { 'original_test.jpg' }
  let(:file_name) { 'test.jpg' }
  let(:width) { 200 }
  let(:height) { 200 }
  let(:format) { 'JPEG' }
  let(:mime_type) { 'image/jpeg' }
  let(:status) { 'ACTIVE' }
  let(:file_size) { 12345678 }
  let(:quality) { 90 }

  describe '#call' do
    it 'should add photo to album' do

      expect(user_repository).to receive(:find).with(user_id) { user }
      expect(album_repository).to receive(:find).with(album_id) { album }
      expect(album_repository).to receive(:add_photo).with(album_id, photo_id) { true }
      expect(photo_repository).to receive(:find).with(photo_id) { photo }

      response = subject.call(params)

      expect(response.success).to be true
      expect(response.data).to be album
      expect(response.errors).to be_empty
    end

    it 'should validate required params' do
      expect { subject.call({}) }.to raise_error(ArgumentError)
      expect { subject.call({:user_id => user_id}) }.to raise_error(ArgumentError)
      expect { subject.call({:photo_id => photo_id}) }.to raise_error(ArgumentError)
      expect { subject.call({:album_id => album_id}) }.to raise_error(ArgumentError)
      expect { subject.call({:photo_id => photo_id, :album_id => album_id}) }.to raise_error(ArgumentError)
    end

    it 'should validate if user exists' do
      expect(user_repository).to receive(:find).with(user_id) { nil }

      response = subject.call(params)

      expect(response.success).to be false
      expect(response.errors[:user_id]).not_to be_empty
      expect(response.data).to be_nil
    end

    it 'should validate if photo exists' do
      expect(user_repository).to receive(:find).with(user_id) { user }
      expect(photo_repository).to receive(:find).with(photo_id) { nil }

      response = subject.call(params)

      expect(response.success).to be false
      expect(response.errors[:photo_id]).not_to be_empty
      expect(response.data).to be_nil
    end

    it 'should validate if album exists' do
      expect(user_repository).to receive(:find).with(user_id) { user }
      expect(photo_repository).to receive(:find).with(photo_id) { photo }
      expect(album_repository).to receive(:find).with(album_id) { nil }

      response = subject.call(params)

      expect(response.success).to be false
      expect(response.errors[:album_id]).not_to be_empty
      expect(response.data).to be_nil
    end
  end
end