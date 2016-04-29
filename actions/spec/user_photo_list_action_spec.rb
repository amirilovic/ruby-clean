require_relative '../../repositories/module'
require_relative '../module'

describe App::Actions::UserPhotoListAction do
  subject { described_class.new(user_repository, photo_repository) }

  let(:photo_repository) { instance_double('App::Repositories::PhotoRepository') }
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

  let(:original_file_name) { 'original_test.jpg' }
  let(:file_name) { 'test.jpg' }
  let(:width) { 200 }
  let(:height) { 200 }
  let(:format) { 'JPEG' }
  let(:mime_type) { 'image/jpeg' }
  let(:user_id) { 1 }
  let(:status) { 'ACTIVE' }
  let(:file_size) { 12345678 }
  let(:quality) { 90 }

  let(:photos) {
    [
        App::Entities::Photo.new({:original_file_name => original_file_name,
                                  :file_name => file_name,
                                  :width => width,
                                  :height => height,
                                  :format => format,
                                  :mime_type => mime_type,
                                  :user_id => user_id,
                                  :status => status,
                                  :file_size => file_size,
                                  :quality => quality
                                 }),
        App::Entities::Photo.new({:original_file_name => original_file_name,
                                  :file_name => file_name,
                                  :width => width,
                                  :height => height,
                                  :format => format,
                                  :mime_type => mime_type,
                                  :user_id => user_id,
                                  :status => status,
                                  :file_size => file_size,
                                  :quality => quality
                                 })
    ]
  }

  describe '#call' do
    it 'should return user photo list' do

      expect(user_repository).to receive(:find).with(user_id) { user }

      expect(photo_repository).to receive(:all).with({:user_id => user_id}, sort_by, page, per_page) { photos }

      response = subject.call(params)

      expect(response.success).to be true
      expect(response.data).to be_a Array
      expect(response.data).to be photos
      expect(response.errors).to be_empty
    end

    it 'should validate required params' do
      expect { subject.call({}) }.to raise_error(ArgumentError)
      expect { subject.call({:sort_by => sort_by, :per_page => per_page, :page => page}) }.to raise_error(ArgumentError)
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