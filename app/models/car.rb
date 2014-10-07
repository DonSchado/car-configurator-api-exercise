class Car < ActiveRecord::Base

  serialize :levels, Array

  monetize :price_cents, as: 'price'


  def as_json(options={})
    { description: description, levels: levels, price: price.to_s }
  end
end
