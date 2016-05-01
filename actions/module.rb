require_relative '../repositories/module'

module App::Actions
  require_relative '../entities/module'
  require_relative 'base_action'
  require_relative 'action_response'
  require_relative 'user_register_action'
  require_relative 'user_login_action'
  require_relative 'user_email_confirm_action'
  require_relative 'user_list_action'
  require_relative 'user_update_action'
  require_relative 'user_delete_action'
  require_relative 'photo_upload_action'
  require_relative 'user_photo_list_action'
  require_relative 'photo_view_action'
  require_relative 'album_create_action'
end