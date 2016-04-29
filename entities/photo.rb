module App::Entities
  class Photo < BaseEntity
    attr_accessor :original_file_name
    attr_accessor :file_name
    attr_accessor :width
    attr_accessor :height
    attr_accessor :format
    attr_accessor :mime_type
    attr_accessor :quality
    attr_accessor :user_id
    attr_accessor :user
    attr_accessor :file_size
    attr_accessor :status

    validates :original_file_name, presence: true
    validates :file_name, presence: true
    validates :user_id, presence: true
    validates :width, presence: true
    validates :height, presence: true
    validates :format, presence: true
    validates :mime_type, presence: true
    validates :quality, presence: true
    validates :file_size, presence: true
    validates :status, presence: true, inclusion: {in: %w(ACTIVE DELETED ARCHIVED)}
  end
end