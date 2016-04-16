require_relative '../../repositories/module'
require_relative '../module'

describe App::Actions::UserEmailConfirmAction do
  subject { described_class.new(repo) }

  let(:repo) { App::Repositories::UserRepository.new }

  let(:params) { {:email => email, :email_confirmation_token => email_confirmation_token } }

  let(:user) { App::Entities::User.new(:email => email, :name => name, :password => password, :password_confirmation => password_confirmation, :status => status, :email_confirmed => email_confirmed, :email_confirmation_token => email_confirmation_token) }

  let(:email) { 'pera@pera.com' }
  let(:email_confirmed) { false }
  let(:email_confirmation_token) {'please_confirm'}
  let(:name) { 'Pera Peric' }
  let(:password) { '12345678' }
  let(:password_confirmation) { password }
  let(:status) { 'ACTIVE' }

  before (:each) do
    repo.save(user)
  end

  describe '#call' do
    it 'should confirm user email' do
      response = subject.call(params)

      expect(response.success).to be true
      expect(response.data).to be_a App::Entities::User
      expect(response.data.id).not_to be_nil
      expect(response.data.email_confirmed).to be true
      expect(response.errors).to be_empty

    end

    it 'should validate if required params are present' do
      expect {subject.call({})}.to raise_error(ArgumentError)
      expect {subject.call({:email => email})}.to raise_error(ArgumentError)
      expect {subject.call({:email_confirmation_token => email_confirmation_token})}.to raise_error(ArgumentError)
    end

    it 'should validate if user with email exists' do
      params[:email] = 'fgfgfg'

      response = subject.call(params)

      expect(response.success).to be false
      expect(response.errors[:email]).not_to be_empty

    end

    it 'should validate if user email is already confirmed' do
      user.email_confirmed = true
      repo.save(user)

      response = subject.call(params)

      expect(response.success).to be false
      expect(response.errors[:email_confirmed]).not_to be_empty

    end

    it 'should validate email confirmation token' do
      params[:email_confirmation_token] = 'test'

      response = subject.call(params)

      expect(response.success).to be false
      expect(response.errors[:email_confirmation_token]).not_to be_empty

    end
  end
end