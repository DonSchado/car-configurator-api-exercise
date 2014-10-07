class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :car_config_id
      t.string :status
      t.string :car_house
      t.text :address

      t.timestamps
    end
  end
end
