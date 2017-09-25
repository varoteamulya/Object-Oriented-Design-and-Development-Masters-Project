class CreateCheckouts < ActiveRecord::Migration[5.1]
  def change
    create_table :checkouts do |t|
      t.string :email_id
      t.string :license
      t.string :status

      t.timestamps
    end
  end
end
