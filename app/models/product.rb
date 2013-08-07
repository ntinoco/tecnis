# encoding: UTF-8

class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  attr_accessible :description, :name, :price, :reference, :image, :category, :product_categories_attributes, :enable, :available
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  accepts_nested_attributes_for :product_categories, allow_destroy: true

  validates_presence_of :product_categories, :presence => true

  scope :available, :conditions => {:available => true}

  def self.filter_by_params(b_admin, params)
    if params[:category_id]
      prods = b_admin ? Category.find(params[:category_id]).products.page(params[:page]).per(8) : Category.find(params[:category_id]).products.available.page(params[:page]).per(8)
    else
      prods = b_admin ? Product.page(params[:page]).per(8) : Product.available.page(params[:page]).per(8)
    end
    #prods.available unless b_admin
  end

  #overwrites internal rails method for descriptive urls
  def to_param
    "#{id} #{name}".parameterize
  end

  def image_path
  	path = self.image.blank? ? "/public/images/no_product_image.jpg" : self.image.url 
  end

  def self.page_description(params)
    if params[:category_id]
       Category.find(params[:category_id]).description
    else
       "Productos disponibles"
    end
  end

  def st_availability
    if !available
      "NO disponible"
    else
      "Sí"
    end
  end

  def reduced_description
    description[0,150] + "..."
  end

  #http://pastebin.com/g9jt6UQ1
  def initialized_categorizations # this is the key method
    [].tap do |o|
      Category.all.each do |category|
        if c = product_categories.find { |c| c.category_id == category.id }
          o << c.tap { |c| c.enable ||= true }
        else
          o << ProductCategory.new(category: category)
        end
      end
    end
  end

  def self.IVA
    21
  end

  def self.IVA_amount(amount)
    amount * (Product.IVA / 100.00) rescue 0
  end

  def self.amount_with_tax(amount)
    amount * (1 + (Product.IVA / 100.00))
  end
end
