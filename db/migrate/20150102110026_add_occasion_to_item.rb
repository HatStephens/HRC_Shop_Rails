class AddOccasionToItem < ActiveRecord::Migration
  def change
    add_column :items, :occasion, :string
  end
end
