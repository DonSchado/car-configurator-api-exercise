class Car < ActiveRecord::Base

  serialize :levels, Array

  monetize :price_cents, as: 'price'

end
