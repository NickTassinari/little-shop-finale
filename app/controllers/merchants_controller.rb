class MerchantsController < ApplicationController
  def show 
    @merchant = Merchant.find(params[:id])
    @merchant_random = PhotoBuilder.merchant_random
  end
end