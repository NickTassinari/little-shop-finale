require "rails_helper"

RSpec.describe "Merchant Dashboard Index Page" do 
  before(:each) do 
    @merchant = create(:merchant)
    
    @item_1 = create(:item, merchant: @merchant)
    
    @customer_1 = create(:customer)
    @invoice_1 = @customer_1.invoices.create!(status: "completed")
    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id)
    @transaction_1 = Transaction.create!(result: "success", invoice: @invoice_1)
    
    @customer_2 = create(:customer)
    @invoice_2 = @customer_2.invoices.create!(status: "completed")
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id)

    @customer_3 = create(:customer)
    @invoice_3 = @customer_3.invoices.create!(status: "completed")
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_3.id)
    @transaction_4 = Transaction.create!(result: "success", invoice: @invoice_3)
    @transaction_5 = Transaction.create!(result: "success", invoice: @invoice_3)
    @transaction_6 = Transaction.create!(result: "success", invoice: @invoice_3)
    
    @customer_4 = create(:customer)
    @invoice_4 = @customer_4.invoices.create!(status: "completed")
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_4.id)
    @transaction_7 = Transaction.create!(result: "success", invoice: @invoice_4)
    @transaction_8 = Transaction.create!(result: "success", invoice: @invoice_4)
    
    
    @customer_5 = create(:customer)
    @invoice_5 = @customer_5.invoices.create!(status: "completed")
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_5.id)
    @transaction_9 = Transaction.create!(result: "success", invoice: @invoice_5)
    @transaction_10 = Transaction.create!(result: "success", invoice: @invoice_5)
    @transaction_11 = Transaction.create!(result: "success", invoice: @invoice_5)
    @transaction_17 = Transaction.create!(result: "success", invoice: @invoice_5)
    
    @customer_6 = create(:customer)
    @invoice_6 = @customer_6.invoices.create!(status: "completed")
    @invoice_item_6 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_6.id)
    @transaction_12 = Transaction.create!(result: "success", invoice: @invoice_6)
    @transaction_13 = Transaction.create!(result: "success", invoice: @invoice_6)
    @transaction_14 = Transaction.create!(result: "success", invoice: @invoice_6)
    @transaction_15 = Transaction.create!(result: "success", invoice: @invoice_6)
    @transaction_16 = Transaction.create!(result: "success", invoice: @invoice_6)
  end

  describe "Merchant Dashboard Display" do 
    #User Story 1
    it "displays the name of the merchant" do 
      visit merchant_dashboard_path(@merchant) 

      expect(page).to have_content(@merchant.name)
    end

    #user story 2
    it "displays links to merchant items index and merchant invoices index" do 
      visit merchant_dashboard_path(@merchant)

      expect(page).to have_link("Items Index")
      expect(page).to have_link("Invoices Index")
    end
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see the names of the top 5 customers
    # who have conducted the largest number of successful transactions with my merchant
    # And next to each customer name I see the number of successful transactions they have
    # conducted with my merchant
    #user story 3
    it "displays the names of the top 5 customers and number of successful transactions" do 
      
      
      visit merchant_dashboard_path(@merchant)
      expect(page).to have_content("Top Five Customers")

      within "#top_customers"

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
end