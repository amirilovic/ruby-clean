require_relative '../module'

describe App::Entities::User do
  subject { App::Entities::User.new(:email => email, :name => name, :password => password) }

  let(:email) { 'pera@pera.com' }
  let(:name) { 'Pera Peric' }
  let(:password) { '12345678' }

  describe '#valid?' do

    it 'should be valid' do
      expect(subject.valid?).to be true
    end

    describe '#email' do
      it 'should be present' do
        subject.email = nil
        expect(subject.valid?).to be false
      end

      it 'should be well formatted' do
        subject.email = 'abc'
        expect(subject.valid?).to be false
      end
    end

    describe '#name' do
      it 'should be present' do
        subject.name = nil
        expect(subject.valid?).to be false
      end
    end

    describe '#password' do
      it 'should be present' do
        subject.password = nil
        expect(subject.valid?).to be false
      end

      it 'should be at least 8 chars long' do
        subject.password = '123'
        expect(subject.valid?).to be false
      end
    end

    describe '#password_confirmation' do
      it 'should be validated if defined' do
        subject.password_confirmation = password + '1'
        expect(subject.valid?).to be false
      end

      it 'should be same as password' do
        subject.password_confirmation = password
        expect(subject.valid?).to be true
      end
    end
  end

  describe '#authenticate' do
    it 'should accept right password' do
      expect(subject.authenticate(password)).not_to be nil
    end

    it 'should reject wrong password' do
      expect(subject.authenticate(password + '1')).to be false
    end
  end
end