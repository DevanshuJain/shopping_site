class ChargesController < ApplicationController
  def new
  
  end

  def create
    @amount = 0 
    quant = 0
    
    if current_user.orders.where(status: false).exists? 
      @order = current_user.orders.where(status: false).last
    end
    if @order.carts.exists?
      @order.carts.each do |p| 
       quant = quant + p.quantity 
       @amount = @amount + p.price 
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
    redirect_to products_index_path
  end
end
