module App::Actions
  class ActionResponse
    attr_accessor :success, :data, :errors

    def initialize
      @errors = Hash.new{ |hash, key| hash[key] = []}
      @success = false
    end
  end
end