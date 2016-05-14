require_relative '../../repositories/module'
require_relative '../module'

describe App::Actions::UserAlbumListAction do
  subject { described_class.new(user_repository, album_repository) }

  let(:album_repository) { instance_double('App::Repositories::PhotoRepository') }
  let(:user_repository) { instance_double('App::Repositories::UserRepository') }

  let(:params) { {:user_id => user_id, :sort_by => sort_by, :per_page => per_page, :page => page} }

  let(:user_id) { 1 }
  let(:sort_by) { [:id, :asc] }
  let(:per_page) { 20 }
  let(:page) { 1 }

  let(:user) { App::Entities::User.new(:id => user_id, :email => email, :name => name, :password => password, :status => status) }

  let(:email) { 'pera@pera.com' }
  let(:name) { 'Pera Peric' }
  let(:password) { '12345678' }
  let(:status) { 'ACTIVE' }

  let(:name) { 'The Best Album in the World!' }
  let(:user_id) { 1 }
  let(:status) { 'ACTIVE' }

  let(:albums) {
    [
        App::Entities::Album.new({:name => name, :user_id => user_id, :status => status}),
        App::Entities::Album.new({:name => name, :user_id => user_id, :status => status})
    ]
  }

  describe '#call' do
    it 'should return user album list' do

      expect(user_repository).to receive(:find).with(user_id) { user }

      expect(album_repository).to receive(:all).with({:user_id => user_id}, sort_by, page, per_page) { albums }

      response = subject.call(params)

      expect(response.success).to be true
      expect(response.data).to be_a Array
      expect(response.data).to be albums
      expect(response.errors).to be_empty
    end

    it 'should validate required params' do
      expect { subject.call({}) }.to raise_error(ArgumentError)
      expect { subject.call({:sort_by => sort_by, :per_page => per_page, :page => page}) }.to raise_error(ArgumentError)
    end

    it 'should validate if user exists' do
      expect(user_repository).to receive(:find).with(user_id).and_raise(App::Repositories::RecordNotFoundError)
      expect { subject.call(params) }.to raise_error(App::Repositories::RecordNotFoundError)
    end

  end
end