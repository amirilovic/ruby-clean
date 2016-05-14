module App::Actions
  class AlbumAddPhotoAction < BaseAction

    def initialize(album_repository, photo_repository, user_repository)
      @album_repository = album_repository
      @photo_repository = photo_repository
      @user_repository = user_repository
    end

    def call(params)
      response = ActionResponse.new

      user_id = params[:user_id]
      album_id = params[:album_id]
      photo_id = params[:photo_id]

      raise ArgumentError.new('user_id is undefined.') if user_id.blank?
      raise ArgumentError.new('photo_id is undefined.') if photo_id.blank?
      raise ArgumentError.new('album_id is undefined.') if album_id.blank?

      user = @user_repository.find(user_id)

      photo = @photo_repository.find(photo_id)

      album = @album_repository.find(album_id)

      @album_repository.add_photo(album.id, photo.id)
      response.success = true
      response.data = album

      response
    end
  end
end
