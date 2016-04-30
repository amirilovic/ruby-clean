module App::Actions
  class PhotoViewAction < BaseAction

    def initialize(photo_repository)
      @photo_repository = photo_repository
    end

    def call(params)
      response = ActionResponse.new

      photo_id = params[:photo_id]

      raise ArgumentError.new('photo_id is undefined.') if photo_id.blank?

      photo = @photo_repository.find(photo_id)
      response.success = true
      response.data = photo

      response
    end
  end
end
