require_relative '../../repositories/module'
require_relative '../module'

describe App::Actions::UserLoginAction do
  subject { described_class.new(repo) }

  let(:repo) { App::Repositories::UserRepository.new }

  let(:params) { {:email => email, :password => password} }

  let(:user) { App::Entities::User.new(:email => email, :name => name, :password => password, :password_confirmation => password_confirmation, :status => status, :email_confirmed => email_confirmed) }

  let(:email) { 'pera@pera.com' }
  let(:email_confirmed) { true }
  let(:name) { 'Pera Peric' }
  let(:password) { '12345678' }
  let(:password_confirmation) { password }
  let(:status) { 'ACTIVE' }

  before(:each) do
    repo.save(user)
  end

  describe '#call' do
    it 'should login user' do
      response = subject.call(params)

      expect(response.success).to be true
      expect(response.data).to be_a App::Entities::User
      expect(response.data.id).not_to be_nil
      expect(response.errors).to be_empty

    end

    it 'should validate required params' do
      expect { subject.call({}) }.to raise_error(ArgumentError)
      expect { subject.call({:email => email}) }.to raise_error(ArgumentError)
      expect { subject.call({:password => password}) }.to raise_error(ArgumentError)
    end

    it 'should validate if user with email exists' do
      response = subject.call({:email => 'test', :password => password})
      expect(response.success).to be false
      expect(response.errors[:email]).not_to be_empty
    end

    it 'should validate if password is correct' do
      response = subject.call({:email => email, :password => 'dfghgfjghjgh'})
      expect(response.success).to be false
      expect(response.errors[:email]).not_to be_empty
    end

    it 'should validate if email is confirmed' do
      user.email_confirmed = false
      repo.save(user)
      response = subject.call(params)
      expect(response.success).to be false
      expect(response.errors[:email]).not_to be_empty
    end
  end
end