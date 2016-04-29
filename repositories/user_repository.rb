module App::Repositories
  class UserRepository < BaseRepository
    def find_by_email(email)
      @entities.find {|e| e.email == email}
    end

    def find_by_email_and_password(email, password)
      @entities.find {|e| e.email == email && e.password == password}
    end
  end
end