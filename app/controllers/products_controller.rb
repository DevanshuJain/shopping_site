class ProductsController < ApplicationController
  load_and_authorize_resource
  
  def index
    if current_user.has_role? :seller
      seller_product_path
    else
      @products = Product.all
    end
  end

  
  def seller_product
    @products=current_user.products.all
  end


  def product_status
    @products=current_user.products
  end


  def show
    @product=Product.find(params[:id])
  end

  def edit
    @product=current_user.products.find(params[:id])
  end

  def update
    @product=current_user.products.find(params[:id])
    p=@product.all_quantity
    @product.all_quantity=(p)+(params[:product][:available_quantity]).to_i

    if @product.update(product_params)
      redirect_to seller_product_path
    else
      render 'new'
    end
  end

  def new
    @product=current_user.products.new
  end

  def create
    @product = current_user.products.new(product_params)
    @product.all_quantity=params[:product][:available_quantity]
    if @product.save
      redirect_to seller_product_path
    else
      render 'new'
    end
  end

  def destroy
    @product=current_user.products.find(params[:id])
    if @product.destroy
      redirect_to seller_product_path
    else
      render 'new'
    end
  end

  private
  def product_params
    params.require(:product).permit(:title, :description, :price, :avatar, :available_quantity)
  end
end
