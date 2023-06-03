require "rails_helper"

RSpec.describe "Merchants Invoices Index" do 
  # Merchant Invoices Index
  # As a merchant,
  # When I visit my merchant's invoices index (/merchants/:merchant_id/invoices)
  # Then I see all of the invoices that include at least one of my merchant's items
  # And for each invoice I see its id
  # And each id links to the merchant invoice show page
  before(:each) do 
    @merchant = create(:merchant)
    
    @item_1 = create(:item, merchant: @merchant)
    
    @customer_1 = create(:customer)
    @invoice_1 = @customer_1.invoices.create!(status: "completed")
    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id)
    @transaction_1 = Transaction.create!(result: "success", invoice: @invoice_1)
    
    @customer_2 = create(:customer)
    @invoice_2 = @customer_2.invoices.create!(status: "completed")
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id)

    @customer_3 = create(:customer)
    @invoice_3 = @customer_3.invoices.create!(status: "completed")
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_3.id)
    @transaction_4 = Transaction.create!(result: "success", invoice: @invoice_3)
    @transaction_5 = Transaction.create!(result: "success", invoice: @invoice_3)
    @transaction_6 = Transaction.create!(result: "success", invoice: @invoice_3)
    
    @customer_4 = create(:customer)
    @invoice_4 = @customer_4.invoices.create!(status: "completed")
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_4.id)
    @transaction_7 = Transaction.create!(result: "success", invoice: @invoice_4)
    @transaction_8 = Transaction.create!(result: "success", invoice: @invoice_4)
    
    
    @customer_5 = create(:customer)
    @invoice_5 = @customer_5.invoices.create!(status: "completed")
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_5.id)
    @transaction_9 = Transaction.create!(result: "success", invoice: @invoice_5)
    @transaction_10 = Transaction.create!(result: "success", invoice: @invoice_5)
    @transaction_11 = Transaction.create!(result: "success", invoice: @invoice_5)
    @transaction_17 = Transaction.create!(result: "success", invoice: @invoice_5)
    
    @customer_6 = create(:customer)
    @invoice_6 = @customer_6.invoices.create!(status: "completed")
    @invoice_item_6 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_6.id)
    @transaction_12 = Transaction.create!(result: "success", invoice: @invoice_6)
    @transaction_13 = Transaction.create!(result: "success", invoice: @invoice_6)
    @transaction_14 = Transaction.create!(result: "success", invoice: @invoice_6)
    @transaction_15 = Transaction.create!(result: "success", invoice: @invoice_6)
    @transaction_16 = Transaction.create!(result: "success", invoice: @invoice_6)
  end

  it "has all the invoices that include at least one merchant item and lists each invoice id" do 
    visit merchant_invoices_path(@merchant)

    expect(page).to have_content("Invoice ##{@invoice_1.id}")
    expect(page).to have_content("Invoice ##{@invoice_2.id}")
    expect(page).to have_content("Invoice ##{@invoice_3.id}")
  end

  it "links to merchant invoice show page from each id" do 

  end
end