module App::Entities
  class Album < BaseEntity
    attr_accessor :name
    attr_accessor :user_id
    attr_accessor :user
    attr_accessor :photo_ids
    attr_accessor :photos

  end
end