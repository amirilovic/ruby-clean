module App::Entities
  class Album < BaseEntity
    attr_accessor :name
    attr_accessor :user_id
    attr_accessor :user
    attr_accessor :photo_ids
    attr_accessor :photos
    attr_accessor :status

    validates :name, presence: true
    validates :user_id, presence: true
    validates :status, presence: true, inclusion: {in: %w(ACTIVE DELETED ARCHIVED)}

    def initialize(args)
      self.photo_ids = []
      super(args)
    end

  end
end