require_relative '../../repositories/module'
require_relative '../module'

describe App::Actions::UserRegisterAction do
  subject { described_class.new(repo) }

  let(:repo) { App::Repositories::UserRepository.new }

  let(:params) { {:email => email, :name => name, :password => password, :password_confirmation => password_confirmation} }

  let(:user) { App::Entities::User.new(:email => email, :name => name, :password => password, :password_confirmation => password_confirmation, :status => status, :email_confirmed => email_confirmed) }

  let(:email) { 'pera@pera.com' }
  let(:email_confirmed) { true }
  let(:name) { 'Pera Peric' }
  let(:password) { '12345678' }
  let(:password_confirmation) { password }
  let(:status) { 'ACTIVE' }


  describe '#call' do
    it 'should create new user' do
      response = subject.call(params)

      expect(response.success).to be true
      expect(response.data).to be_a App::Entities::User
      expect(response.data.id).not_to be_nil
      expect(response.errors).to be_empty
      expect(response.data.email_confirmation_token).not_to be_empty
    end

    it 'should validate password confirmation' do
      params[:password_confirmation] = 'tesgdf'
      response = subject.call(params)

      expect(response.success).to be false
      expect(response.errors[:password_confirmation]).not_to be_empty
    end

    it 'should validate if user is valid' do
      params[:name] = nil

      response = subject.call(params)

      expect(response.success).to be false
      expect(response.errors[:name]).not_to be_empty
    end

    it 'should validate if there is user with same email address' do
      repo.save(user)

      response = subject.call(params)

      expect(response.success).to be false
      expect(response.errors[:email]).not_to be_empty
    end
  end
end