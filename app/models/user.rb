class User < ActiveRecord::Base
  def as_json options
    camelize_keys(super(options.merge({
        :except => [:password],
                                      })))
  end

  def camelize_keys(hash)
    values = hash.map do |key, value|
      [key.camelize(:lower), value]
    end
    Hash[values]
  end
end