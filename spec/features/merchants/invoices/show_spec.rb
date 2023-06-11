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

    expect(page).to have_content("Invoice ##{@invoice_3.id}")
    expect(page).to have_content("Invoice Status: #{@invoice_3.status}")
    expect(page).to have_content("Created on: #{@invoice_3.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer Name: #{@invoice_3.customer.first_name} #{@invoice_3.customer.last_name}")
    end 
  end
  #user story 16
  it "has info of items on the invoice" do 
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_3.id}"

    within "#item_name" do 
      expect(page).to have_content("#{@item_1.name}")
    end 

    within "#item_quan" do 
      expect(page).to have_content("#{@invoice_item_3.quantity}")
    end 
    
    within "#uni_price" do 
      expect(page).to have_content("$20.00")
    end 

    within "#status" do 
      expect(page).to have_content("#{@invoice_item_3.status}")
    end 

    within "#item_info" do 
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

  #user story 18
  it "can update status of invoice item" do 
    visit  "/merchants/#{@merchant.id}/invoices/#{@invoice_3.id}"


      page.select("packaged", from: :invoice_item_status)
      click_button("Update Item Status")
      
      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_3.id}")
      
      within "#status" do 
        expect(page).to have_content("packaged")
      end

      page.select("shipped", from: :invoice_item_status)
      click_button("Update Item Status")
      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_3.id}")
      
      within "#status" do 
        expect(page).to have_content("shipped")
      end 
  end

  describe "displays subtotal and grand total revenue" do 
    it "dollar amount" do 
      @merchant_3 = create(:merchant)
      @item_9 = create(:item, merchant: @merchant_3, unit_price: 2000)
      @customer_7 = create(:customer)
      @coupon_1 = Coupon.create!(name: "BOGO $25 OFF", discount_type: "dollar", discount: 25, coupon_code: "Juneteenthbogo", merchant_id: @merchant_3.id, status: "active")
      @invoice_7 = create(:invoice, status: 0, customer: @customer_7, coupon_id: @coupon_1.id)
      @invoice_item_7 = create(:invoice_item, quantity: 1, unit_price: @item_9.unit_price, item_id: @item_9.id, invoice_id: @invoice_7.id)
      @transaction_4 = create(:transaction, result: "success", invoice: @invoice_7)
      @transaction_5 = create(:transaction, result: "success", invoice: @invoice_7)
      @transaction_6 = create(:transaction, result: "success", invoice: @invoice_7)

      visit merchant_invoice_path(@merchant_3, @invoice_7)

      within("#invoice_totals") do 
        expect(page).to have_content("Subtotal: #{@invoice_7.total_revenue}")
        expect(page).to have_content("Grand Total Revenue: #{@invoice_7.grand_total}")
        expect(page).to have_content("Coupon: #{@coupon_1.name}")
        expect(page).to have_content("#{@coupon_1.coupon_code}")
        expect(page).to have_link("#{@coupon_1.name} #{@coupon_1.coupon_code}")
      end
    end

    it "percent amount" do 
      @merchant_4 = create(:merchant)
      @item_10 = create(:item, merchant: @merchant_4, unit_price: 2000)
      @customer_8 = create(:customer)
      @coupon_2 = Coupon.create!(name: "Everything 50% off", discount_type: "percentage", discount: 50, coupon_code: "ToyotaThon", merchant_id: @merchant_4.id, status: "active")
      @invoice_8 = create(:invoice, status: 0, customer: @customer_8, coupon_id: @coupon_2.id)
      @invoice_item_8 = create(:invoice_item, quantity: 1, unit_price: @item_10.unit_price, item_id: @item_10.id, invoice_id: @invoice_8.id)
      @transaction_7 = create(:transaction, result: "success", invoice: @invoice_8)
      @transaction_8 = create(:transaction, result: "success", invoice: @invoice_8)
      @transaction_9 = create(:transaction, result: "success", invoice: @invoice_8)

      visit merchant_invoice_path(@merchant_4, @invoice_8)
      within("#invoice_totals") do
        expect(page).to have_content("Subtotal: #{@invoice_8.total_revenue}")
        expect(page).to have_content("Grand Total Revenue: #{@invoice_8.grand_total}")
        expect(page).to have_content("Coupon: #{@coupon_2.name}")
        expect(page).to have_content("#{@coupon_2.coupon_code}")
        expect(page).to have_link("#{@coupon_2.name} #{@coupon_2.coupon_code}")
      end
    end 
  end
end