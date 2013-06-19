class Product < ActiveRecord::Base
  attr_accessible :description, :name, :picture, :price, :reference
end
