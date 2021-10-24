class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.datetime :date
      t.string :detail_1_type
      t.string :detail_1_data
      t.string :detail_2_type
      t.string :detail_2_data
      t.string :detail_3_type
      t.string :detail_3_data
      t.belongs_to :subarea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
