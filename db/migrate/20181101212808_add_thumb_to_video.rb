class AddThumbToVideo < ActiveRecord::Migration[5.1]
  def change
    change_table :videos do |t|
      t.string :thumb
    end
  end
end
