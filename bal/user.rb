module App::BAL
  class User < Entity
    def greet(s)
      puts "Hello #{s} :)"
    end
  end
end