module App::Actions
  class UserPhotoListAction < BaseAction
    def initialize(user_repository, photo_repository)
      @user_repository = user_repository
      @photo_repository = photo_repository
    end

    def call(params)
      response = ActionResponse.new

      user_id = params[:user_id]
      per_page = params[:per_page] || 20
      page = params[:page] || 1
      sort_by = params[:sort_by] || [:id, :asc]

      raise ArgumentError.new('user_id is undefined.') if user_id.blank?

      user = @user_repository.find(user_id)

      response.success = true
      response.data = @photo_repository.all({:user_id => user_id}, sort_by, page, per_page)

      response
    end
  end
end