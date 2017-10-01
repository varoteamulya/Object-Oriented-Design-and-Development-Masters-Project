class ModifySuggestions < ActiveRecord::Migration[5.1]
  def change
    add_column :suggestions, :suggested_by, :string
  end
end
