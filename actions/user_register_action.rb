module App::Actions
  class UserRegisterAction < BaseAction

    def initialize(user_repository)
      @user_repository = user_repository
    end

    def call(params)
      response = ActionResponse.new

      user = App::Entities::User.new(:name => params[:name],
                                     :email => params[:email],
                                     :password_confirmation => params[:password_confirmation],
                                     :password => params[:password],
                                     :status => 'ACTIVE')

      if !user.password_confirmation.nil?
        if user.valid?
          same_user = @user_repository.find_by_email(user.email)
          if same_user.nil?
            user.email_confirmation_token = self.generate_token
            @user_repository.save(user)
            response.success = true
            response.data = user
          else
            response.errors[:email] << 'is not unique'
          end
        else
          response.errors = user.errors.messages
        end
      else
        response.errors[:password_confirmation] << 'can\'t be blank'
      end

      response
    end

    def generate_token
      SecureRandom.hex(10)
    end
  end
end