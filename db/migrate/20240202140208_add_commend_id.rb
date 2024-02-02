class AddCommendId < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :comment_id, :integer
    add_index :comments, :comment_id
  end
end
