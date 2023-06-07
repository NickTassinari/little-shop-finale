class Admin::MerchantsController < ApplicationController
  def index
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
    @merchant_random = PhotoBuilder.merchant_random
  end

  def new
    @merchant = Merchant.new
  end

  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      flash[:success] = "#{merchant.name} was successfully created"
      redirect_to admin_merchants_path
    else
      flash[:error] = "Please enter a merchant name"
      redirect_to new_admin_merchant_path
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      if !params[:merchant][:status].nil?
        redirect_to admin_merchants_path
      else
        flash[:success] = "#{@merchant.name} was successfully updated"
        redirect_to admin_merchant_path(@merchant)
      end
    else
      flash[:error] = "Merchant must have a name"
      redirect_to edit_admin_merchant_path(@merchant)
    end
  end


  private
  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end