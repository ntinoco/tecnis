class Image < ActiveRecord::Base
  belongs_to :product
  attr_accessible :binary_data, :content_type, :description, :file_name
end
