class RemoveProductIdFromCategories < ActiveRecord::Migration
  def up
    remove_column :categories, :product_id
  end

  def down
    add_column :categories, :product_id, :integer
  end
end
