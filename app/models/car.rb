class Car < ActiveRecord::Base

  serialize :levels, Array

  monetize :price_cents, as: 'price'


  def as_json(options={})
    { description: description, levels: levels, price: price.to_s }
  end

  def formatted_price
    price.format(no_cents: true, symbol: false, thousands_separator: false)
  end
end
