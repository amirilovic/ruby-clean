module App::Entities
  class User < BaseEntity
    include ActiveModel::SecurePassword

    has_secure_password

    attr_accessor :password_digest
    attr_accessor :name
    attr_accessor :email

    validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
    validates :name, presence: true
    validates :password, length: { minimum: 8 }

  end
end