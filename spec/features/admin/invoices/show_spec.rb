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
end