require_relative '../module'

describe App::Entities::Photo do
  subject { App::Entities::Photo.new({:original_file_name => original_file_name,
                                      :file_name => file_name,
                                      :width => width,
                                      :height => height,
                                      :format => format,
                                      :mime_type => mime_type,
                                      :user_id => user_id,
                                      :status => status,
                                      :file_size => file_size,
                                      :quality => quality
                                     }) }

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

  describe '#valid?' do

    it 'should be valid' do
      expect(subject.valid?).to be true
    end

    describe '#original_file_name' do
      it 'should be present' do
        subject.original_file_name = nil
        expect(subject.valid?).to be false
      end
    end

    describe '#file_name' do
      it 'should be present' do
        subject.file_name = nil
        expect(subject.valid?).to be false
      end
    end

    describe '#width' do
      it 'should be present' do
        subject.width = nil
        expect(subject.valid?).to be false
      end
    end

    describe '#height' do
      it 'should be present' do
        subject.height = nil
        expect(subject.valid?).to be false
      end
    end

    describe '#format' do
      it 'should be present' do
        subject.format = nil
        expect(subject.valid?).to be false
      end
    end

    describe '#mime_type' do
      it 'should be present' do
        subject.mime_type = nil
        expect(subject.valid?).to be false
      end
    end

    describe '#file_size' do
      it 'should be present' do
        subject.file_size = nil
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