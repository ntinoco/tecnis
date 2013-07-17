class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :description
      t.string :content_type
      t.string :file_name
      t.binary :binary_data
      t.references :product

      t.timestamps
    end
    add_index :images, :product_id
  end
end
