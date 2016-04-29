module App::Repositories
  class BaseRepository
    def initialize
      @entities = []
    end

    def find(id)
      @entities.find { |u| u.id == id }
    end

    def save(entity)
      raise ArgumentError.new('Entity is not defined.') if entity.nil?

      raise ArgumentError.new('Entity is invalid.') unless entity.valid?

      if entity.id
        index = @entities.find_index { |e| e.id == entity.id }
        raise ArgumentError.new('Entity does not exist.') if index.nil?
        @entities[index] = entity
      else
        id = SecureRandom.uuid
        entity.id = id
        @entities << entity
      end
    end

    def all(filter, sort_by, page, per_page)
      page = 1 if page < 1
      per_page = 20 if per_page < 1 || per_page > 1000
      count = @entities.count
      max_page = (count.to_f / per_page.to_f).ceil
      page = max_page if page > max_page

      start = (page - 1) * per_page
      length = [per_page, count - start].min

      data = @entities.slice(start, length)

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
      index = @entities.find_index { |e| e.id == id }
      raise ArgumentError.new('Entity does not exist.') if index.nil?

      @entities.delete_at(index)
    end

    def count
      @entities.count
    end
  end
end