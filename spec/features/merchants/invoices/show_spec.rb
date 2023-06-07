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
end