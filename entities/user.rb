module App::Entities
  class User < BaseEntity
    include ActiveModel::SecurePassword

    has_secure_password

    attr_accessor :password_digest
    attr_accessor :name
    attr_accessor :email
    attr_accessor :email_confirmed
    attr_accessor :email_confirmation_token
    attr_accessor :status

    validates :email, presence: true, email: true
    validates :name, presence: true
    validates :password, length: {minimum: 8}
    validates :status, presence: true, inclusion: {in: %w(ACTIVE DELETED ARCHIVED)}

    def initialize(options={})
      @email_confirmed = false
      super(options)
    end

  end
end