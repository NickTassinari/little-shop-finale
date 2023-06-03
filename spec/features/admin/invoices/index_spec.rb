require "rails_helper"

RSpec.describe "Admin Invoice Index Page" do
  before(:each) do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_2)
    @invoice_3 = create(:invoice, customer: @customer_2)
  end

  describe "Admin Invoices Display" do
    # User Story 32
    it "displays a list of all Invoice IDs" do
      visit admin_invoices_path
      
      expect(page).to have_content("Invoice ##{@invoice_1.id}")
      expect(page).to have_content("Invoice ##{@invoice_2.id}")
      expect(page).to have_content("Invoice ##{@invoice_3.id}")
    end

    it "has links to each admin Invoice show page" do
      visit admin_invoices_path

      expect(page).to have_link("#{@invoice_1.id}", href: "/admin/invoices/#{@invoice_1.id}")
      expect(page).to have_link("#{@invoice_2.id}", href: "/admin/invoices/#{@invoice_2.id}")
      expect(page).to have_link("#{@invoice_3.id}", href: "/admin/invoices/#{@invoice_3.id}")

      click_link("#{@invoice_2.id}")
      expect(page).to have_current_path("/admin/invoices/#{@invoice_2.id}")
    end
  end
end