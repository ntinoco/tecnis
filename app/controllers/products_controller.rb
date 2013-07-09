class ProductsController < ApplicationController
  before_filter :build_product, :only => [:new]
  before_filter :load_product, :only => [:edit]
  before_filter :build_or_load_categorization, :only => [:new, :edit]
  before_filter :process_categorizations_attrs, only: [:create, :update]

  # GET /products
  # GET /products.json
  def index
    @products = Product.available

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])
    @product.image = params[:image] if params[:image]
    #params[:product][:category_ids].each{|c|
    #  @product.category = c
    #}

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])
    @product.image = params[:image] if params[:image]

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def add_to_cart
    session[:cart] ||= Cart.new
    session[:cart] = session[:cart].add_product(params[:id])
    redirect_to :products
  end

  def remove_from_cart
    session[:cart] = session[:cart].remove_product(params[:id])
    redirect_to :products
  end

  def clear_cart
    session[:cart].reset
    session[:cart] = nil
    redirect_to :products
  end

  private
  def build_product
    @product = Product.new
  end

  def load_product
    @product = Product.find_by_id(params[:id])
    @product || invalid_url
  end

  def build_or_load_categorization
    Category.where('id not in (?)', @product.categories).each do |c|
      @product.product_categories.new(:category => c)
    end
  end

  def render_with_categorization(template)
    build_or_load_categorization
    render :action => template
  end

  def process_categorizations_attrs
    params[:product][:product_categories_attributes].values.each do |cat_attr|
      cat_attr[:_destroy] = true if cat_attr[:enable] != '1'
    end
  end

end
