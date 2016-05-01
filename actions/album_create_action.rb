module App::Actions
  class AlbumCreateAction < BaseAction

    def initialize(album_repository, user_repository)
      @album_repository = album_repository
      @user_repository = user_repository
    end

    def call(params)
      response = ActionResponse.new

      user_id = params[:user_id]
      name = params[:name]

      raise ArgumentError.new('user_id is undefined.') if user_id.blank?
      raise ArgumentError.new('name is undefined.') if name.blank?

      user = @user_repository.find(user_id)
      if user
        album = App::Entities::Album.new(
            :user_id => user_id,
            :status => 'ACTIVE',
            :name => name
        )

        @album_repository.save(album)
        response.success = true
        response.data = album
      else
        response.errors[:user_id] << 'can\'t be found.'
      end
      response
    end
  end
end
