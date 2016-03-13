require_relative '../validators/email_validator'

describe EmailValidator do
  subject { EmailValidator.new({:attributes => [:email]}) }

  describe '#email?' do
    it 'should be valid email' do
      expect(subject.email?('aaa@bbb.cc')).to be true
    end

    it 'should be invalid email without top level domain' do
      expect(subject.email?('a@b')).to be false
    end

    it 'should be invalid email without random string' do
      expect(subject.email?('fdgfgfgfgfgf')).to be false
    end

    it 'should be invalid email too short top level domain' do
      expect(subject.email?('aaa@aaa.c')).to be false
    end

    it 'should be invalid email without username' do
      expect(subject.email?('@a.com')).to be false
    end
  end
end
