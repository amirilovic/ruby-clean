module App::Actions
  class UserLoginAction < BaseAction

    def initialize(user_repository)
      @user_repository = user_repository
    end

    def call(params)
      response = ActionResponse.new

      email = params[:email]
      password = params[:password]

      raise ArgumentError.new('Email is undefined.') if email.blank?
      raise ArgumentError.new('Password is undefined.') if password.blank?

      user = @user_repository.find_by_email(email)
      if user && user.authenticate(password)
        response.success = true
        response.data = user
      else
        response.errors[:email] << 'Email or password invalid.'
      end
      response
    end
  end
end