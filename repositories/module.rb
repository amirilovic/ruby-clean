module App
  module Repositories
    require_relative '../entities/module'
    require_relative 'base_repository'
    require_relative 'user_repository'
    require_relative 'photo_repository'
    require_relative 'file_repository'
    require_relative 'album_repository'
  end
end