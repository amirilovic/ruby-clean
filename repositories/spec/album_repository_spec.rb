require_relative '../module'

describe App::Repositories::AlbumRepository do
  subject { described_class.new }

  let(:album) { App::Entities::Album.new({:name => album_name, :user_id => user_id, :status => album_status}) }

  let(:user_id) { 1 }
  let(:photo_id) { 1 }
  let(:album_name) { 'The Best Album in the World!' }
  let(:album_status) { 'ACTIVE' }

  describe '#add_photo' do
    it 'should add photo to album' do
      subject.save(album)
      response = subject.add_photo(album.id, photo_id)
      expect(response).to be true
      expect(album.photo_ids.length).to be 1
    end

    it 'should not add already inserted photo' do
      subject.save(album)
      response = subject.add_photo(album.id, photo_id)
      expect(response).to be true
      expect(album.photo_ids.length).to be 1

      response = subject.add_photo(album.id, photo_id)
      expect(response).to be false
      expect(album.photo_ids.length).to be 1
    end
  end
end