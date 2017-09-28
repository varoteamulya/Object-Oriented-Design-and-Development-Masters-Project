class ModifyCarCheckoutsTable < ActiveRecord::Migration[5.1]
  def change
    add_column :car_checkouts, :time_from, :datetime
    add_column :car_checkouts, :time_to, :datetime
  end
end
