require 'active_model'

module App
  module Entities
    require_relative 'validators/email_validator'
    require_relative 'validators/uri_validator'
    require_relative 'base_entity'
    require_relative 'user'
    require_relative 'photo'
    require_relative 'album'
  end
end