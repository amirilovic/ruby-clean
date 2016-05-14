module App::Actions
  class UserDeleteAction < BaseAction

    def initialize(user_repository)
      @user_repository = user_repository
    end

    def call(params)
      response = ActionResponse.new

      user = @user_repository.find(params[:id])

      user = @user_repository.delete(user.id)
      response.success = true
      response.data = user

      response
    end
  end
end