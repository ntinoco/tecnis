class RenameTableProductCategories < ActiveRecord::Migration
  def up
  	rename_table :products_categories, :product_categories
  end

  def down
  	rename_table :product_categories, :products_categories
  end
end
