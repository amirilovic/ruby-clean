module App::Actions
  class UserUpdateAction < BaseAction

    def initialize(user_repository)
      @user_repository = user_repository
    end

    def call(params)
      response = ActionResponse.new

      user = @user_repository.find(params[:id])

      user.name = params[:name]

      if user.valid?
        @user_repository.save(user)
        response.success = true
        response.data = user
      else
        response.errors = user.errors.messages
      end

      response
    end
  end
end