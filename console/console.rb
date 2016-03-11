require_relative '../app'

module App::Console
  def self.run
    user = App::BAL::User.new
    user.greet 'Sasa'
  end
end

App::Console::run()