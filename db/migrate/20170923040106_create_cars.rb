class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :License
      t.string :Manufacturer
      t.string :Model
      t.string :Hourly
      t.string :Style
      t.string :Location
      t.string :Availability
      t.string :Checkout

    end
  end
end
