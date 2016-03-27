module App::Repositories
  class UserRepository < BaseRepository
    def initialize
      @users = []
    end

    def find(id)
      @users.find {|u| u.id == id}
    end

    def find_by_email(email)
      @users.find {|u| u.email == email}
    end

    def save(user)
      raise ArgumentError.new('User is not defined.') if user.nil?

      raise ArgumentError.new('User is invalid.') unless user.valid?

      if user.id
        index = @users.find_index {|u| u.id == user.id}
        raise ArgumentError.new('User does not exist.') if index.nil?
        @users[index] = user
      else
        id = SecureRandom.uuid
        user.id = id
        @users << user
      end
    end

    def all(filter, sort_by, page, per_page)
      page = 1 if page < 1
      per_page = 20 if per_page < 1 || per_page > 1000
      count = @users.count
      max_page = (count.to_f / per_page.to_f).ceil
      page = max_page if page > max_page

      start = (page - 1) * per_page
      length = [per_page, count - start].min

      data = @users.slice(start, length)

      {
          data: data,
          filter: filter,
          sort_by: sort_by,
          page: page,
          per_page: per_page,
          total_count: count
      }
    end

    def delete(id)
      index = @users.find_index {|u| u.id == id}
      raise ArgumentError.new('User does not exist.') if index.nil?

      @users.delete_at(index)
    end

    def count
      @users.count
    end
  end
end