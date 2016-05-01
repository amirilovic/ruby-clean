require_relative '../module'

describe App::Entities::Album do
  subject { App::Entities::Album.new({:name => name, :user_id => 1, :status => status}) }

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
  end
end