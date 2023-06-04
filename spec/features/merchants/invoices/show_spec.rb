require "rails_helper"

RSpec.describe "Merchants Invoice Show Page" do 
  # Merchant Invoice Show Page
  # As a merchant
  # When I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
  # Then I see information related to that invoice including:

  # Invoice id
  # Invoice status
  # Invoice created_at date in the format "Monday, July 18, 2019"
  # Customer first and last name
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
end