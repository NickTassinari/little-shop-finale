class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    if @item.update(item_params)
      redirect_to merchant_item_path(@merchant, @item)
      flash[:alert] = "Item updated successfully!"
    else
      redirect_to edit_merchant_item_path(@merchant, @item)
      flash[:alert] = "Error updating item, incomplete form"
    end
  end

  def status_update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])

    if params[:commit] == "Enable"
      @item.enable!
    elsif params[:commit] == "Disable"
      @item.disable!
    end

    redirect_to merchant_items_path(@merchant)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id, :status)
  end
end