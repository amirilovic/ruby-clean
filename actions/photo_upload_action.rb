module App::Actions
  class PhotoUploadAction < BaseAction

    def initialize(photo_repository, user_repository, file_repository, image_utility)
      @photo_repository = photo_repository
      @user_repository = user_repository
      @file_repository = file_repository
      @image_utility = image_utility
    end

    def call(params)
      response = ActionResponse.new

      user_id = params[:user_id]
      file_path = params[:file_path]

      raise ArgumentError.new('user_id is undefined.') if user_id.blank?
      raise ArgumentError.new('file_path is undefined.') if file_path.blank?

      user = @user_repository.find(user_id)
      if user
        image_info = @image_utility.info(file_path)

        photo = App::Entities::Photo.new(
            :user_id => user_id,
            :status => 'ACTIVE',
            :width => image_info.width,
            :height => image_info.height,
            :quality => image_info.quality,
            :format => image_info.format,
            :mime_type => image_info.mime_type,
            :file_size => image_info.file_size,
            :original_file_name => image_info.file_name
        )

        photo.file_name = @file_repository.put(file_path)

        @photo_repository.save(photo)
        response.success = true
        response.data = photo
      else
        response.errors[:user_id] << 'can\'t be found.'
      end
      response
    end
  end
end
