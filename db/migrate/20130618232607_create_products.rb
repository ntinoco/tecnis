class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.binary :picture
      t.string :reference
      t.decimal :price
      t.text :description

      t.timestamps
    end
  end
end
