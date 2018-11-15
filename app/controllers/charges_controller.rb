class ChargesController < ApplicationController
  def new
  
  end

  def create
    r=0
    @amount = 0 
    quant = 0
    if current_user.orders.where(status: false).exists? 
      @order = current_user.orders.where(status: false).last
    end
    if @order.carts.exists?
      @order.carts.each do |p| 
        @produc=Product.find(p.product_id)
       
        @product=Product.find(p.product_id)
      
        if p.quantity <= @product.available_quantity
          r=(@product.available_quantity)-(p.quantity)
          @product.update_attributes(:available_quantity => r)
          quant = quant + p.quantity 
          @amount = @amount + p.price 
        else
          redirect_to products_path, :notice => "product quantity are not available"
          return
        end
      end
    end
    @order.total_product = quant
    @order.total_price = @amount
    @order.save
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd',
      :metadata => {Order: "#{@order.id}"}
    )
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end
end
