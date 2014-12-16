class AddPcValueToItems < ActiveRecord::Migration
  def change
    add_column :items, :PCValue, :float
  end
end
