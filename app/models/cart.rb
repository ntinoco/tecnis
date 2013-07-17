class Cart
  attr_reader :items

  def initialize
    ## - product_id
    ## - quantity
    
    @items = Hash.new
    #session[:cart] ||= Cart.new
  end

  def add_product(product_id)
    if @items.has_key?(product_id)
      @items[product_id] = @items[product_id].to_i + 1
    else
      @items[product_id] = 1
    end
    self
    #session[:cart] = @items
  end

  def remove_product(product_id)
    if @items.has_key?(product_id)
      @items[product_id] = @items[product_id].to_i - 1
      @items.delete(product_id) if @items[product_id].to_i < 1
    end
    self
    #session[:cart] = @items
  end

  def reset
    @items.clear
    nil
    #session[:cart] = nil
  end
end