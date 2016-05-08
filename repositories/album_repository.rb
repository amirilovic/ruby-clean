module App::Repositories
  class AlbumRepository < BaseRepository
    def add_photo (album_id, photo_id)
      album = self.find(album_id)
      result = false
      if album.photo_ids.index(photo_id).nil?
        album.photo_ids << photo_id
        result = true
      end
      result
    end
  end
end