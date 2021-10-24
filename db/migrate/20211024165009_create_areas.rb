class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas do |t|
      t.string :name
      t.integer :position
      t.integer :streak
      t.integer :level
      t.belongs_to :user, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
