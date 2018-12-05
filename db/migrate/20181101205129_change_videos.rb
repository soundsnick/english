class ChangeVideos < ActiveRecord::Migration[5.1]
  def change
    change_table :videos do |t|
      t.string :file
    end
  end
end
