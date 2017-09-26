class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :license
      t.string :manufacturer
      t.string :model
      t.string :hourly
      t.string :style
      t.string :location
      t.string :availability
      t.string :checkout

      t.timestamps
    end
  end
end
