class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.boolean :permission, default: false
      t.integer :level, default: 0

      t.timestamps
    end
  end
end
