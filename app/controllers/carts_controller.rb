class CartsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:callback]

  def index
    if current_user.orders.where(status: false).exists?
      @order = current_user.orders.where(status: false).last
      @carts = @order.carts.all
    else
      redirect_to products_path, :notice =>"product are not avaliable"
    end 
  end

  def my_order
    @orders=current_user.orders.where(:status => true)
  end


  def callback
    if params[:data][:object][:metadata][:Order]
      @order=Order.find(params[:data][:object][:metadata][:Order])
      @order.update_attributes(:status => :true)
      user=User.find(@order.user_id)
      UserMailer.sample_email(user).deliver_now
      @order.carts.each do |p|
        @product=Product.find(p.product_id)
        @user=User.find(@product.user_id)
        UserMailer.seller_email(@user).deliver_now
      end
      # respond_to do |format|
      #    format.xml 
        # flash[:notice] = "product placed succesfully" 
      # end
    end
    # byebug
    # redirect_to root_path,:notice =>"product placed succesfully"  and return
    render 'callback'
  end

  def add_to_cart
    @product = Product.find(params[:id]) 
    if current_user.orders.where(status: false).exists?
      @order = current_user.orders.last
    else
      @order = current_user.orders.new
      @order.save
    end  
    if @order.carts.exists?
      @order.carts.each do |c|
        if c.product_id == @product.id
          c.increment! :quantity
          @a = @product.price*c.quantity
          c.update_attributes(:price => @a)
          redirect_to products_path,:notice =>"product add succesfully"
          return
        end
      end
      cart_make
    else
      cart_make
    end
  end

  def cart_make
    @cart = @order.carts.new
    @cart.quantity = "1"
    @cart.price = @product.price
    @cart.product_id = @product.id
    @cart.save
    redirect_to products_path,:notice =>"product add succesfully"
  end

  def remove
    @cart=Cart.find(params[:id])
    if @cart.destroy
      redirect_to carts_path
    end
    # if current_user.orders.where(:status => false).exists?
    #   p=current_user.orders.where(:status => false).last
      # p.carts.each do |p|
      #   byebug
      
      #   @cart=Cart.find(params[:id])
      #   if p.id == @cart.id
      #     @cart.destroy
      #     redirect_to carts_path   
      #   end
      # end
    # end
  end

  def update
    @cart=Cart.find(params[:id])
    @cart.update_attributes(:quantity => params[:data])
    @product=Product.find(@cart.product_id)
    @a = @product.price*@cart.quantity
    @cart.update_attributes(:price => @a)
    respond_to do |format|
      format.js 
      format.html { redirect_to carts_path, notice: "Save comment completed!" } 
    end
  end
end
