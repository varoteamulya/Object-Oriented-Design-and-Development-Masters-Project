class CreateCarCheckouts < ActiveRecord::Migration[5.1]
  def change
    create_table :car_checkouts do |t|
      t.string :license
      t.string :checkout_by
      t.integer :duration
      t.datetime :checkout_at

      t.timestamps
    end
  end
end
