require "rails_helper"

RSpec.describe "Admin Invoice Show Page" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_1)
    @item_4 = create(:item, merchant: @merchant_1)
    @item_5 = create(:item, merchant: @merchant_1)
    @item_6 = create(:item, merchant: @merchant_1)
    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_2)
    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, status: 1)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, status: 1)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id, status: 0)
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_1.id, status: 2)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, status: 1)
    @invoice_item_6 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_2.id, status: 1)
    @invoice_item_7 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_2.id, status: 2)
    @invoice_item_8 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_2.id, status: 0)
  end

  describe "Admin Invoice Details" do
    # User Story 33
    it "displays the invoice details" do
      visit admin_invoice_path(@invoice_1)

      within("#invoice-details") do
        expect(page).to have_content("Invoice ##{@invoice_1.id}")
        expect(page).to have_content("Status: #{@invoice_1.status}")
        expect(page).to have_content("Created on: #{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")

        expect(page).to have_content("Customer:")
        expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
        expect(page).to_not have_content("#{@customer_2.first_name} #{@customer_2.last_name}")

        expect(page).to_not have_content("Invoice ##{@invoice_2.id}")
      end
    end
  end

  describe "Admin Invoice Items Details" do
    # User Story 34
    it "displays all of the items on the invoice with their details" do
      visit admin_invoice_path(@invoice_1)
      require 'pry'; binding.pry

    end
  end
end