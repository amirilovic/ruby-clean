module App::Entities
  class Album < BaseEntity
    attr_accessor :name
    attr_accessor :user_id
    attr_accessor :user
    attr_accessor :photo_ids
    attr_accessor :photos

    validates :name, presence: true
    validates :user_id, presence: true
  end
end