class Merchants::InvoicesController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def show 
    @invoice = Invoice.find(params[:id])
    @customer = @invoice.customer 
    @invoice_item = InvoiceItem.where(invoice_id: params[:id]).first 
    @merchant = Merchant.find(params[:merchant_id])
  end
end