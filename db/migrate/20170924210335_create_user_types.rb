class CreateUserTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :user_type do |t|
      t.string :name
      t.integer :type

      t.timestamps
    end
  end
end
