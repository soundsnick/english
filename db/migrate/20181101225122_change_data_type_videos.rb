class ChangeDataTypeVideos < ActiveRecord::Migration[5.1]
  def change
    remove_column :videos, :category_id
    change_table :videos do |t|
      t.integer :category_id
    end
  end
end
