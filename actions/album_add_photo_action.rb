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
      if user
        photo = @photo_repository.find(photo_id)
        if photo
          album = @album_repository.find(album_id)
          if album
            @album_repository.add_photo(album_id, photo_id)
            response.success = true
            response.data = album
          else
            response.errors[:album_id] << 'can\'t be found.'
          end
        else
          response.errors[:photo_id] << 'can\'t be found.'
        end
      else
        response.errors[:user_id] << 'can\'t be found.'
      end
      response
    end
  end
end
