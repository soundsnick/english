class ChangeVideosToCourses < ActiveRecord::Migration[5.1]
  def change
    rename_column :videos, :category_id, :course_id
  end
end
