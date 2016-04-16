require_relative '../module'

describe App::Repositories::UserRepository do
  subject { described_class.new }

  let(:user) { App::Entities::User.new(:email => email, :name => name, :password => password, :password_confirmation => password_confirmation, :status => status) }

  let(:email) { 'pera@pera.com' }
  let(:name) { 'Pera Peric' }
  let(:password) { '12345678' }
  let(:password_confirmation) { password }
  let(:status) { 'ACTIVE' }

  describe '#save' do
    it 'should save the user' do
      subject.save(user)
      expect(subject.count).to be 1
    end
  end
end