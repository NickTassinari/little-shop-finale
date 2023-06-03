require "rails_helper"

RSpec.describe "Admin Invoice Show Page" do
  before(:each) do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_2)
  end

  describe "Admin Invoice Details" do
    # User Story 33
    it "displays the invoice ID number at the top" do
      visit admin_invoice_path(@invoice_1)
      
      expect(page).to have_content("Invoice ##{@invoice_1.id}")
      expect(page).to_not have_content("Invoice ##{@invoice_2.id}")
    end

    it "displays the invoice status" do
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_content("Status: #{@invoice_1.status}")
    end

    it "displays the created_at date in the format 'Weekday, Month Day, Year' " do
      visit admin_invoice_path(@invoice_1.created_at)

      expect(page).to have_content("Created on: #{@invoice_1.created_at.strftime("%A, %B %-d, %Y")}")
    end

    it "displays the Invoice's customer first and last name" do
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_content("Customer:")
      expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
      expect(page).to_not have_content("#{@customer_2.first_name} #{@customer_2.last_name}")
    end 
  end
end