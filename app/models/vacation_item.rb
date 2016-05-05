class VacationItem < ActiveRecord::Base
  belongs_to :vacation

  def as_json options
    camelize_keys(super(options))
  end

  def camelize_keys(hash)
    values = hash.map do |key, value|
      [key.camelize(:lower), value]
    end
    Hash[values]
  end
end