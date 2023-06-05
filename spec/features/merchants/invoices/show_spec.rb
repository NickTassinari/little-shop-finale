require "rails_helper"

RSpec.describe "Merchants Invoice Show Page" do 
  #user story 15
  before(:each) do 
    top_customer_data
  end

  it "has information related to the invoice" do 
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_3.id}"
    # visit merchant_invoices_path(@merchant, @invoice_3)
    within "#invoice_info" do 

    expect(page).to have_content("Invoice ID: #{@invoice_3.id}")
    expect(page).to have_content("Invoice Status: #{@invoice_3.status}")
    expect(page).to have_content("Created on: #{@invoice_3.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer Name: #{@invoice_3.customer.first_name} #{@invoice_3.customer.last_name}")
    end 
  end
  #user story 16
  it "has info of items on the invoice" do 
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_3.id}"
    within "#item_info" do 

      expect(page).to have_content("Name: #{@item_1.name}")
      expect(page).to have_content("Quantity: #{@invoice_item_3.quantity}")
      expect(page).to have_content("Unit Price: $20.00")
      expect(page).to have_content("Status: #{@invoice_item_3.status}")
      expect(page).to_not have_content(@merchant_2.name)
      expect(page).to_not have_content(@invoice_item_7.quantity)
      expect(page).to_not have_content(@invoice_7.status)
    end
  end

  #user story 17 
  it "shows total revenue from invoice" do 
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_3.id}"

    expect(page).to have_content("Total Revenue: $20.00")

    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_6.id}"

    expect(page).to have_content("Total Revenue: $100.00")
  end
end