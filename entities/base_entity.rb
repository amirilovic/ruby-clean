module App::Entities
  class BaseEntity
    include ActiveModel::Model

    attr_accessor :id
  end
end