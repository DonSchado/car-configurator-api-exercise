class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.text :levels
      t.string :description
      t.integer :price_cents, default: 0

      t.timestamps
    end
  end
end
