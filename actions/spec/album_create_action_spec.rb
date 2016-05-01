require_relative '../../repositories/module'
require_relative '../module'

describe App::Actions::AlbumCreateAction do
  subject { described_class.new(album_repository, user_repository) }

  let(:user_repository) { instance_double('App::Repositories::UserRepository') }
  let(:album_repository) { App::Repositories::AlbumRepository.new }

  let(:params) { {:user_id => user_id, :name => name} }

  let(:user_id) { 1 }
  let(:name) { 'Test Album' }

  let(:user) { App::Entities::User.new(:id => user_id, :email => email, :name => name, :password => password, :status => status) }

  let(:email) { 'pera@pera.com' }
  let(:name) { 'Pera Peric' }
  let(:password) { '12345678' }
  let(:status) { 'ACTIVE' }

  describe '#call' do
    it 'should create album' do

      expect(user_repository).to receive(:find).with(user_id) { user }

      response = subject.call(params)

      expect(response.success).to be true
      expect(response.data).to be_a App::Entities::Album
      expect(response.data.id).not_to be_nil
      expect(response.data.name).to be name
      expect(response.data.user_id).to be user_id
      expect(response.errors).to be_empty
    end

    it 'should validate required params' do
      expect { subject.call({}) }.to raise_error(ArgumentError)
      expect { subject.call({:user_id => user_id}) }.to raise_error(ArgumentError)
      expect { subject.call({:name => name}) }.to raise_error(ArgumentError)
    end

    it 'should validate if user exists' do
      expect(user_repository).to receive(:find).with(user_id) { nil }

      response = subject.call(params)

      expect(response.success).to be false
      expect(response.errors[:user_id]).not_to be_empty
      expect(response.data).to be_nil
    end
  end
end