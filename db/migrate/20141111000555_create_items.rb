class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, limit: 50
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
