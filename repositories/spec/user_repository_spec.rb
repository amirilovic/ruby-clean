require_relative '../module'

describe App::Repositories::UserRepository do
  subject { App::Repositories::UserRepository.new }

  let(:user) { App::Entities::User.new(:email => email, :name => name, :password => password, :password_confirmation => password_confirmation) }

  let(:email) { 'pera@pera.com' }
  let(:name) { 'Pera Peric' }
  let(:password) { '12345678' }
  let(:password_confirmation) { password }


  describe '#save' do
    it 'should save the user' do
      subject.save(user)
      expect(subject.count).to be 1
    end
  end
end