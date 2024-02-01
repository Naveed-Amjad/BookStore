class AddColumnsToBook < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :title, :string
    add_column :books, :description, :string
    add_index :books, :title
  end
end
