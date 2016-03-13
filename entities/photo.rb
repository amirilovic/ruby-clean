module App::Entities
  class Photo < BaseEntity
    attr_accessor :url
    attr_accessor :size
    attr_accessor :user_id
    attr_accessor :user

    validates :url, presence: true, uri: true
    validates :user_id, presence: true
    validates :size, presence: true
  end
end