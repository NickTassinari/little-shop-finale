require "rails_helper"

RSpec.describe "Merchants Invoices Index" do 
  # User Story 14 Merchant Invoices Index
  before(:each) do 
    top_customer_data
  end

  it "has all the invoices that include at least one merchant item and lists each invoice id" do 
    visit merchant_invoices_path(@merchant)

    expect(page).to have_content("Invoice ##{@invoice_1.id}")
    expect(page).to have_content("Invoice ##{@invoice_2.id}")
    expect(page).to have_content("Invoice ##{@invoice_3.id}")
  end

  it "links to merchant invoice show page from each id" do 
    visit merchant_invoices_path(@merchant)

    expect(page).to have_link("#{@invoice_1.id}", href: merchant_invoices_path(@merchant, @invoice_1))
    expect(page).to have_link("#{@invoice_2.id}", href: merchant_invoices_path(@merchant, @invoice_2))
    expect(page).to have_link("#{@invoice_3.id}", href: merchant_invoices_path(@merchant, @invoice_3))

    click_link("#{@invoice_3.id}") 
    expect(current_path).to eq(merchant_invoices_path(@merchant, @invoice_3))
  end
end