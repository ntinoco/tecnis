class RenameColumn < ActiveRecord::Migration
  def up
  	remove_column :products, :picture
  	add_column :products, :image_id, :integer
  end

  def down
  	#do nothing
  end
end
