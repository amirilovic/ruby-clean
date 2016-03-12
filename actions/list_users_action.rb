module App::Actions
  class ListUsersAction < BaseAction
    def initialize(user_repository)
      @user_repository = user_repository
    end

    def call(filter, sort_by, page, per_page)
      response = ActionResponse.new
      response.data = @user_repository.all(filter, sort_by, page, per_page)
      response
    end
  end
end