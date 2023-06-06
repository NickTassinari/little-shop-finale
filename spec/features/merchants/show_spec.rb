require "rails_helper"

RSpec.describe "Merchant Dashboard Index Page" do 

  describe "Merchant Dashboard Display" do 
    #User Story 1
    it "displays the name of the merchant" do 
      dashboard_data
      visit merchant_dashboard_path(@merchant) 

      expect(page).to have_content(@merchant.name)
    end

    #user story 2
    it "displays links to merchant items index and merchant invoices index" do 
      dashboard_data
      visit merchant_dashboard_path(@merchant)

      expect(page).to have_link("Items Index")
      expect(page).to have_link("Invoices Index")
    end

    #user story 3
    it "displays the names of the top 5 customers and number of successful transactions" do 
      dashboard_data
      
      visit merchant_dashboard_path(@merchant)
      expect(page).to have_content("Top Five Customers")

      within "#top_customers" do 

        expect(page).to have_content(@customer_6.first_name)
        expect(page).to have_content(@customer_5.first_name)
        expect(page).to have_content(@customer_3.first_name)
        expect(page).to have_content(@customer_4.first_name)
        expect(page).to have_content(@customer_1.first_name)
        expect(page).to_not have_content(@customer_2.first_name)

        expect(@customer_6.first_name).to appear_before(@customer_5.first_name)
        expect(@customer_5.first_name).to appear_before(@customer_3.first_name)
        expect(@customer_3.first_name).to appear_before(@customer_4.first_name)
        expect(@customer_4.first_name).to appear_before(@customer_1.first_name)

        expect(page).to have_content("#{@customer_6.first_name} #{@customer_6.last_name} - 5 purchases")
        expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name} - 4 purchases")
        expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name} - 3 purchases")
        expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name} - 2 purchases")
        expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name} - 1 purchases")
      end
    end

    #user story 4 
    it "displays Items Ready to Ship" do 
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      item_3 = create(:item, merchant: merchant, status: 2)
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(:customer)
      invoice_1 = customer_1.invoices.create!(status: "completed")
      invoice_2 = customer_2.invoices.create!(status: "completed")
      invoice_3 = customer_3.invoices.create!(status: "completed")
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: 0)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: 0)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: 2)

      visit merchant_dashboard_path(merchant)

      within("#items_to_ship") do 
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).to_not have_content(item_3.name)
        expect(page).to have_link("Invoice ##{invoice_1.id}")
        expect(page).to have_link("Invoice ##{invoice_2.id}")
        expect(page).to_not have_link("Invoice ##{invoice_3.id}")

        click_link "#{invoice_1.id}"

        expect(current_path).to eq("/merchants/#{merchant.id}/invoices/#{invoice_1.id}")
      end
    end
  end
end