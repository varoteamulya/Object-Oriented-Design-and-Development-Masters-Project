class CreateAvailabilityRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :availability_requests do |t|
      t.string :email
      t.string :license

      t.timestamps
    end
  end
end
