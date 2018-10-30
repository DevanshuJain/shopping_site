class ProductsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @products = Product.all
  end


  def seller_product
    @products=current_user.products.all
  end


  def show
    @product=Product.find(params[:id])
  end

  def edit
    @product=current_user.products.find(params[:id])
  end

  def update
    @product=current_user.products.find(params[:id])
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
    params.require(:product).permit(:title, :description, :price, :avatar)
  end
end
