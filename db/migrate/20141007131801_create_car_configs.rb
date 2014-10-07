class CreateCarConfigs < ActiveRecord::Migration
  def change
    create_table :car_configs do |t|
      t.integer :car_id
      t.integer :leasing_period
      t.integer :leasing_km
      t.string :package
      t.integer :leasing_rate_cents

      t.timestamps
    end
  end
end
