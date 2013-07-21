class Category < ActiveRecord::Base
  attr_accessible :description, :id
  #belongs_to :product
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories

  #scope :not_empty, joins(:products) #.available #.having('available=1')
  #scope :not_empty, where(Product.categories.count => 0)
  #scope :not_empty,  joins(:categories).
  #scope :not_empty, joins(:products).select('distinct categories.*')
  def self.not_empty
  	c = Category.joins(:products).select('distinct categories.*').where('products.available=1')
  	c
  end

  def st_products_uom #units of measure
    count = self.products.count
    uom = count == 1 ? "producto" : "productos"
    "#{count} #{uom}"
  end
end
