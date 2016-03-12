module App::Entities
  class Photo < BaseEntity
    attr_accessor :url
    attr_accessor :size
    attr_accessor :user_id
    attr_accessor :user
  end
end