class Order < ActiveRecord::Base
  belongs_to :car_config

  before_create :set_init_status

  def as_json(options={})
    { id: id, status: status, car_house: car_house, address: address }
  end

  def set_init_status
    self.status = 'created'
  end
end
