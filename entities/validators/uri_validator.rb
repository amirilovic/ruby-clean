require 'active_model'

class UriValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    unless uri?(value)
      record.errors[attribute] << (options[:message] || 'is not an url')
    end
  end

  def uri?(value)
    begin
      uri = URI.parse(value)
      resp = uri.kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      resp = false
    end

    resp
  end
end