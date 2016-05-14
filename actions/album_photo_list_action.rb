module App::Actions
  class AlbumPhotoListAction < BaseAction
    def initialize(album_repository, photo_repository)
      @album_repository = album_repository
      @photo_repository = photo_repository
    end

    def call(params)
      response = ActionResponse.new

      album_id = params[:album_id]
      per_page = params[:per_page] || 20
      page = params[:page] || 1
      sort_by = params[:sort_by] || [:id, :asc]

      raise ArgumentError.new('album_id is undefined.') if album_id.blank?

      album = @album_repository.find(album_id)

      response.success = true
      response.data = @photo_repository.all({:'id.in' => album.photo_ids}, sort_by, page, per_page)

      response
    end
  end
end