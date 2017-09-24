class CreateCarStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :car_status do |t|
      t.string :status
      t.integer :value

      t.timestamps
    end
  end
end
