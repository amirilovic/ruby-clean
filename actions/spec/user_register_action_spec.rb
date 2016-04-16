require_relative '../../repositories/module'
require_relative '../module'

describe App::Actions::UserRegisterAction do
  subject { described_class.new(App::Repositories::UserRepository.new) }

  let(:params) { {:email => email, :name => name, :password => password, :password_confirmation => password_confirmation} }

  let(:email) { 'pera@pera.com' }
  let(:name) { 'Pera Peric' }
  let(:password) { '12345678' }
  let(:password_confirmation) { password }

  describe '#call' do
    it 'should create new user' do
      response = subject.call(params)

      expect(response.success).to be true
      expect(response.data).to be_a App::Entities::User
      expect(response.data.id).not_to be_nil
      expect(response.errors).to be_empty

    end
  end
end