class ChangeSubareasDetailsToString < ActiveRecord::Migration[6.0]
  def change
    change_column :subareas, :details, :string
  end
end
