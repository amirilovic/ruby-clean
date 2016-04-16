module App::Actions
  class UserDeleteAction < BaseAction

    def initialize(user_repository)
      @user_repository = user_repository
    end

    def call(params)
      response = ActionResponse.new

      user = @user_repository.find(params[:id])

      if !user.nil?
        user = @user_repository.delete(user.id)
        response.success = true
        response.data = user
      else
        response.errors[:id] << 'not found'
      end

      response
    end
  end
end