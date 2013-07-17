class ProductCategory < ActiveRecord::Base
  attr_accessible :category_id, :product_id, :category, :enable
  belongs_to :product
  belongs_to :category 

  #attr_accessor :enable, :category
  attr_accessor :enable
end
