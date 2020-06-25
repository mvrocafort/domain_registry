class PaymentsController < ApplicationController  
  require 'paypal-sdk-rest'
  include PayPal::SDK::REST
  protect_from_forgery :except => [:create, :execute]

  PayPal::SDK::REST.set_config(
    :mode => "sandbox",
    :client_id => "AW4I8tHeTC_xdRHrcvpgD2RgBHC-QlhnNO3uP_ZyUjpCanJbxbMvM3qI9nbnSv2ZtrMf_jNOZMuJV055",
    :client_secret => "EG_reR8BdsdgdW59kWzqRL79fVCbBmqX3-S3UaUwf1WF29oNnzITagp-YTXqrHyfWYCklAedLi2LeqWm")

  def create
    # Implement payment creation
    # Build Payment object
    domain_name = params[:domain_name]
    period = params[:period]

    @payment = Payment.new({
      :intent =>  "sale",
      :payer =>  {
        :payment_method =>  "paypal" },
      :redirect_urls => {
        :return_url => "http://127.0.0.1:3000/payment/create",
        :cancel_url => "http://127.0.0.1:3000/" },
      :transactions =>  [{
        :item_list => {
          :items => [{
            :name => domain_name,
            :sku => domain_name,
            :price => '35',
            :currency => "USD",
            :quantity => period[0] }]},
        :amount =>  {
          :total =>  35*period[0].to_i,
          :currency =>  "USD" },
        :description =>  "#{period} domain registration for #{domain_name}" }]})

      @payment.create

    render json: {id: @payment.id} # Fill in the the Payment ID
  end

  def execute
    # Implement payment execution
    payment_id = params[:payment_id]
    payer_id   = params[:payer_id]
    domain_name = params[:domain_name]
    period = params[:period]

    payment = Payment.find(payment_id)

    if payment.execute( :payer_id => payer_id )
      # Success Message
      # Note that you'll need to `Payment.find` the payment again to access user info like shipping address
      # Place domain registration code here (and epp)
     
      
      domain = current_user.domains.new(
        domain_name: domain_name, 
        period: period, 
        registration_date: '05/20/2000', 
        expiration_date: '06/12/2001', 
      )
      domain.save
    else
      payment.error # Error Hash
    end

    render json: {payment_state: payment.state} # Fill in the the payment state
  end

end