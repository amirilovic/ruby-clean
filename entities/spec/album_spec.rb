require_relative '../module'

describe App::Entities::Album do
  subject { App::Entities::Album.new({:name => name, :user_id => user_id, :status => status}) }

  let(:name) { 'The Best Album in the World!' }
  let(:user_id) { 1 }
  let(:status) { 'ACTIVE' }

  describe '#valid?' do

    it 'should be valid' do
      expect(subject.valid?).to be true
    end

    describe '#name' do
      it 'should be present' do
        subject.name = nil
        expect(subject.valid?).to be false
      end
    end

    describe '#user' do
      it 'should be present' do
        subject.user_id = nil
        expect(subject.valid?).to be false
      end
    end

    describe '#status' do
      it 'should be present' do
        subject.status = nil
        expect(subject.valid?).to be false
      end

      it 'should be ACTIVE, DELETED or ARCHIVED' do
        subject.status = 'test'
        expect(subject.valid?).to be false
      end
    end

    describe '#photo_ids' do
      it 'should be initialized' do
        expect(subject.photo_ids).not_to be_nil
      end

      it 'should be initialized with params' do
        photo_ids = [1,2]
        album = App::Entities::Album.new({:photo_ids => photo_ids})
        expect(album.photo_ids).to be photo_ids
      end
    end
  end
end