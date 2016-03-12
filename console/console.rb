require_relative '../app'

module App::Console
  def self.run
    user = App::Entities::User.new
    user.greet 'Sasa'
  end
end

App::Console::run()