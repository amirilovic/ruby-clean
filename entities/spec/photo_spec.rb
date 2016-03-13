require_relative '../module'

describe App::Entities::Photo do
  subject { App::Entities::Photo.new({:url => url, :user_id => user_id, :size => size}) }

  let(:url) { 'https://test.com/photo.jpg' }
  let(:user_id) { 1 }
  let(:size) { 12345678 }

  describe '#valid?' do

    it 'should be valid' do
      expect(subject.valid?).to be true
    end

    describe '#url' do
      it 'should be present' do
        subject.url = nil
        expect(subject.valid?).to be false
      end

      it 'should be well formatted' do
        subject.url = 'bla bla bla'
        expect(subject.valid?).to be false
      end

      it 'should support https' do
        subject.url = 'https://test.com/1.jpg'
        expect(subject.valid?).to be true
      end
    end

    describe '#user_id' do
      it 'should be present' do
        subject.user_id = nil
        expect(subject.valid?).to be false
      end
    end

    describe '#size' do
      it 'should be present' do
        subject.size = nil
        expect(subject.valid?).to be false
      end
    end
  end
end