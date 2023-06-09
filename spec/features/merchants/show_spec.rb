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
      ship_data 

      visit merchant_dashboard_path(@merchant)

      within("#items_to_ship") do 
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
        expect(page).to_not have_content(@item_3.name)
        expect(page).to have_link("Invoice ##{@invoice_1.id}")
        expect(page).to have_link("Invoice ##{@invoice_2.id}")
        expect(page).to_not have_link("Invoice ##{@invoice_3.id}")

        click_link "#{@invoice_1.id}"

        expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")
      end
    end

    it "displays items to ship in order from oldest to newest and formats the date" do 
      ship_data

      visit merchant_dashboard_path(@merchant)

      within("#items_to_ship") do 
        expect(page).to have_content("#{@invoice_1.created_at.strftime('%A, %B%e, %Y')}")
        expect(page).to have_content("#{@invoice_2.created_at.strftime('%A, %B%e, %Y')}")
        link_1 = find_link("#{@invoice_1.id}")
        link_2 = find_link("#{@invoice_2.id}")
        expect(link_1).to appear_before(link_2)
      end
    end

    it "has a link to the coupons index page" do 
      @merchant = Merchant.create!(name: "Ricky's Used Crap")
      @coupon_1 = Coupon.create!(name: "BOGO 25% OFF", discount_type: "percentage", discount: 25, coupon_code: "Juneteenthbogo", merchant_id: @merchant.id)
      visit merchant_dashboard_path(@merchant)
      click_link "View Coupons"
  
      expect(current_path).to eq(merchant_coupons_path(@merchant))
    end
  end
end