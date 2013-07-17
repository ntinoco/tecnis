class AddPrimaryKeyTopProductCategories < ActiveRecord::Migration
  def up
  	add_column :product_categories, :id, :primary_key
  end

  def down
  	#do nothing
  end
end
