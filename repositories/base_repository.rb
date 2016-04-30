module App::Repositories
  class BaseRepository
    def initialize
      @entities = []
    end

    def find(id)
      e = @entities.find { |u| u.id == id }
      raise ArgumentError.new("Entity with id #{id} does not exist.") if e.nil?
      e
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
      sort_by = [:id, :asc] if sort_by.nil? || !sort_by.kind_of?(Array)
      count = @entities.count
      max_page = (count.to_f / per_page.to_f).ceil
      page = max_page if page > max_page

      if filter && filter.kind_of?(Hash)
        a = @entities
        filter.each do |key, value|
          tokens = key.to_s.split('.')
          field = tokens[0]
          condition = tokens[1]

          if condition == 'eq' || condition.nil?
            a = a.select { |e| e.send(key) == value }
          elsif condition == 'gt'
            a = a.select { |e| e.send(key) > value }
          elsif condition == 'gte'
            a = a.select { |e| e.send(key) >= value }
          elsif condition == 'lt'
            a = a.select { |e| e.send(key) < value }
          elsif condition == 'lte'
            a = a.select { |e| e.send(key) <= value }
          end

        end

      end

      data = @entities.sort do |e1, e2|
        a = e1, b = e2
        a = e2, b = e1 if sort_by[1] == :asc
        a.send(sort_by[0]) <=> b.send(sort_by(0))
      end

      start = (page - 1) * per_page
      length = [per_page, count - start].min

      data = data.slice(start, length)

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