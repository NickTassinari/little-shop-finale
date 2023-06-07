class ChangeItemDefaultStatus < ActiveRecord::Migration[7.0]
  def change
    change_column :items, :status, :integer, default: 1
  end
end
