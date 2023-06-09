class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @disabled = Item.disabled_items
    @enabled = Item.enabled_items
    @top_five_items = @merchant.items.top_five_items
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.new(item_params)

    if item.save
      flash[:notice] = "Item created successfully"
      redirect_to merchant_items_path(merchant)
    else
      flash[:alert] = "Item creation failed"
      redirect_to new_merchant_item_path(merchant)
    end
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    # @item_photo = PhotoBuilder.item_photo(@item.name)
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
      @item.update(status: "enabled")
      flash[:notice] = "Item has been enabled"
    elsif params[:commit] == "Disable" 
      @item.update(status: "disabled")
      flash[:notice] = "Item has been disabled"
    end

    redirect_to merchant_items_path(@merchant)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id, :status)
  end
end