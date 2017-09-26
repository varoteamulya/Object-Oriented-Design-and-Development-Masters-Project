class CreateCheckOuts < ActiveRecord::Migration[5.1]
  def change
    create_table :check_outs do |t|

      t.timestamps
    end
  end
end
