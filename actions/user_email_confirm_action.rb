module App::Actions
  class UserEmailConfirmAction < BaseAction

    def initialize(user_repository)
      @user_repository = user_repository
    end

    def call(params)
      response = ActionResponse.new

      email = params[:email]
      email_confirmation_token = params[:email_confirmation_token]

      raise ArgumentError.new('Email is undefined.') if email.blank?
      raise ArgumentError.new('Email confirmation token is undefined.') if email_confirmation_token.blank?

      user = @user_repository.find_by_email(email)
      if user
        if !user.email_confirmed
          if user.email_confirmation_token == email_confirmation_token
            user.email_confirmed = true
            @user_repository.save(user)
            response.success = true
            response.data = user
          else
            response.errors[:email_confirmation_token] << 'is invalid.'
          end
        else
          response.errors[:email_confirmed] << 'already confirmed.'
        end
      else
        response.errors[:email] << 'can\'t be found.'
      end
      response
    end
  end
end