class CreateSubareas < ActiveRecord::Migration[6.0]
  def change
    create_table :subareas do |t|
      t.string :name
      t.integer :position
      t.integer :streak
      t.integer :level
      t.belongs_to :area, null: false, foreign_key: true
      t.integer :details

      t.timestamps
    end
  end
end
