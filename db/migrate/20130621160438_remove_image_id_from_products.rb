class RemoveImageIdFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :image_id
  end

  def down
    add_column :products, :image_id, :integer
  end
end
