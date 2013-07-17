class DropProductCategories < ActiveRecord::Migration
  def up
  	drop_table :product_categories
  end

  def down
  	#do nothing
  end
end
