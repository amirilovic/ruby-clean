require 'active_model'

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless email?(value)
      record.errors[attribute] << (options[:message] || 'is not an email')
    end
  end

  def email?(value)
    !!(value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
  end

end
