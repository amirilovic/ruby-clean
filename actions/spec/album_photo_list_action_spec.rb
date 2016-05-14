require_relative '../../repositories/module'
require_relative '../module'

describe App::Actions::AlbumPhotoListAction do
  subject { described_class.new(album_repository, photo_repository) }

  let(:photo_repository) { instance_double('App::Repositories::PhotoRepository') }
  let(:album_repository) { instance_double('App::Repositories::AlbumRepository') }

  let(:params) { {:album_id => album_id, :sort_by => sort_by, :per_page => per_page, :page => page} }

  let(:album_id) { 1 }
  let(:sort_by) { [:id, :asc] }
  let(:per_page) { 20 }
  let(:page) { 1 }

  let(:album) { App::Entities::Album.new({:name => album_name, :user_id => user_id, :status => album_status, :photo_ids => [photo_id_1, photo_id_2]}) }

  let(:album_name) { 'The Best Album in the World!' }
  let(:album_status) { 'ACTIVE' }
  let(:user_id) { 'ACTIVE' }

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
  let(:photo_id_1) { 1 }
  let(:photo_id_2) { 2 }

  let(:photos) {
    [
        App::Entities::Photo.new({:id => photo_id_1,
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
                                 }),
        App::Entities::Photo.new({:id => photo_id_2,
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
                                 })
    ]
  }

  describe '#call' do
    it 'should return album photo list' do

      expect(album_repository).to receive(:find).with(album_id) { album }

      expect(photo_repository).to receive(:all).with({:'id.in' => album.photo_ids}, sort_by, page, per_page) { photos }

      response = subject.call(params)

      expect(response.success).to be true
      expect(response.data).to be_a Array
      expect(response.data).to be photos
      expect(response.errors).to be_empty
    end

    it 'should validate required params' do
      expect { subject.call({}) }.to raise_error(ArgumentError)
      expect { subject.call({:sort_by => sort_by, :per_page => per_page, :page => page}) }.to raise_error(ArgumentError)
    end

    it 'should validate if album exists' do
      expect(album_repository).to receive(:find).with(album_id).and_raise(App::Repositories::RecordNotFoundError)
      expect { subject.call(params) }.to raise_error(App::Repositories::RecordNotFoundError)
    end
  end
end