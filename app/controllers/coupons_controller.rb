class CouponsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @coupons = @merchant.coupons 
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.find(params[:id])
  end

  def new 
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.new(merchant_id: @merchant.id) 
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.new(coupon_params)
    if @coupon.save && @merchant.active_coupons.count < 6
      redirect_to merchant_coupons_path(@merchant)
    else    
      flash[:error] = "Please fill in all fields correctly Dingbat"
      redirect_to new_merchant_coupon_path
    end
  end

  def update 
    @merchant = Merchant.find(params[:merchant])
    @coupon = Coupon.find(params[:id])
    if params[:deactivate] == "true"
      @coupon.update(status: "deactivated")
    elsif params[:activate] == "true" 
      @coupon.update(status: "active")
    end
    @coupon.save 
    redirect_to "/merchants/#{@merchant.id}/coupons/#{@coupon.id}"
  end

  private 

  def coupon_params
    params.permit(:name, :discount_type, :discount, :coupon_code, :merchant_id, :status)
  end 
end