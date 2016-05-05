class Vacation < ActiveRecord::Base
  belongs_to :user
  has_many :vacation_items

  def as_json options
    camelize_keys(super(options))
  end

  def camelize_keys(hash)
    values = hash.map do |key, value|
      case value
        when Array
          value = value.map { |value| camelize_keys value }
        when Hash
          value = value.map { |key, value| [key.camelize(:lower), value]}
      end

      [key.camelize(:lower), value]
    end
    Hash[values]
  end
end