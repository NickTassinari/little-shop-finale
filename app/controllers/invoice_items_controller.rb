class InvoiceItemsController < ApplicationController
  def update
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(status: params[:invoice_item][:status])
    invoice = Invoice.find(invoice_item.invoice.id)
    merchant = Merchant.find(params[:merchant_id])

    redirect_to("/merchants/#{merchant.id}/invoices/#{invoice.id}")
  end
end