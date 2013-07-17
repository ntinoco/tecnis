class CreateProductsCategoriesTable < ActiveRecord::Migration
  def up
  	create_table :products_categories, :id => false do |t|
        t.references :category
        t.references :product
    end
    add_index :products_categories, [:product_id, :category_id]
    add_index :products_categories, :category_id
  end

  def down
  	drop_table :restaurants_users
  end
end
