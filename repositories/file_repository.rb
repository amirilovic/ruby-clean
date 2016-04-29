module App::Repositories
  class FileRepository
    def put(file_path)
      ext = File.extname(file_path)
      [SecureRandom.hex(10), ext].join('.')
    end

    def fetch(url)

    end

    def delete(url)

    end
  end
end