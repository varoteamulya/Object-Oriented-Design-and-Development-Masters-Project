class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.text :email_id
      t.text :name
      t.text :password
      t.integer :type

      t.timestamps
    end
  end
end
