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
      respond_to do |format|
        format.html {redirect_to products_path,:notice =>"product placed succesfully"}
        format.xml {redirect_to products_path,:notice =>"product placed succesfully"}
      end
    end
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
      @cart = @order.carts.new
      @cart.quantity = "1"
      @cart.price = @product.price
      @cart.product_id = @product.id
      @cart.save
      redirect_to products_path,:notice =>"product add succesfully"
    else
      @cart = @order.carts.new
      @cart.quantity = "1"
      @cart.price = @product.price
      @cart.product_id = @product.id
      @cart.save
      redirect_to products_path,:notice =>"product add succesfully"
    end
  end

  def remove
    if  current_user.orders.where(:status => false).exists?
      p=current_user.orders.where(:status => false).last
      p.carts.each do |p|
        # byebug
      end
    end
  end
  
end
