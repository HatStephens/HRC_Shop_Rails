class AddPcNumberToItems < ActiveRecord::Migration
  def change
    add_column :items, :PCNumber, :integer
  end
end
