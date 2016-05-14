module App::Repositories
  class RecordNotFoundError < StandardError
  end

  class RecordInvalidError < StandardError
  end

  class RecordUndefinedError < StandardError
  end
end