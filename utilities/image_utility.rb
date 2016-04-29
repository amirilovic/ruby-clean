require 'rmagick'

module App::Utilities
  class ImageUtility
    def info(file_path)
      image = Magick::Image.read(file_path).first

      raise ArgumentError('File is not an image.') unless image

      {
          format: image.format,
          mime_type: image.mime_type,
          width: image.columns,
          height: image.rows,
          quality: image.quality,
          file_size: image.file_size,
          file_name: File.basename(image.filename, '.*')
      }
    end
  end
end
