require "rails_helper"

RSpec.describe "Merchant Items Index Page" do
  describe "Merchant Items Index Display", type: :feature do
    before(:each) do 
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1, status: :enabled)
      @item_2 = create(:item, merchant: @merchant_1, status: :disabled)
      @item_3 = create(:item, merchant: @merchant_1, status: :disabled)
      @item_4 = create(:item, merchant: @merchant_1, status: :enabled)
      @item_5 = create(:item, merchant: @merchant_2, status: :disabled)
      @item_6 = create(:item, merchant: @merchant_2, status: :enabled)
      @item_7 = create(:item, merchant: @merchant_2, status: :disabled)
      @item_8 = create(:item, merchant: @merchant_2, status: :enabled)
    end
    # User Story 6
    it "displays a list of the names of all my items" do
      visit merchant_items_path(@merchant_1) 
      expect(page).to have_content("My Items")
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      # expect(page).to_not have_content(@item_3.name)
    end
    #User Story 7
    it "display link of items name, redirects to merchant items show page" do
    visit merchant_items_path(@merchant_1)

    click_link @item_1.name

    expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
    end

    #User Story 9
    it "displays next to each item name a button to disable or enable the item" do
      visit merchant_items_path(@merchant_2)
      
        expect(page).to have_button("Disable")
        expect(page).to have_button("Enable")
    end
    
    it "when user clicks button they are redirected back to the items index, see items status change" do
      visit merchant_items_path(@merchant_2)
      
      within "#disabled_items" do
        click_button("Enable", id: "enable_button#{@item_5.id}")

        expect(current_path).to eq(merchant_items_path(@merchant_2))
        expect(page).to have_content("disabled")
      end
    

      visit merchant_items_path(@merchant_1)
      
      within "#enabled_items" do
        click_button("Disable", id: "disable_button#{@item_1.id}")
      
        expect(current_path).to eq(merchant_items_path(@merchant_1))
        expect(page).to have_content("enabled")
      end
    end
  end

    #US 10 
  describe "Merchant items grouped by status" do
    before(:each) do 
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1, status: :enabled)
      @item_2 = create(:item, merchant: @merchant_1, status: :disabled)
      @item_3 = create(:item, merchant: @merchant_1, status: :disabled)
      @item_4 = create(:item, merchant: @merchant_1, status: :enabled)
    end 
    it "displays two sections, 'Enabled Items' and 'Disabled Items'" do

      visit merchant_items_path(@merchant_1)
    
      within "#enabled_items" do
        expect(page).to have_button("Disable")
        
        click_button("Disable", id: "disable_button#{@item_1.id}")
        expect(current_path).to eq(merchant_items_path(@merchant_1))
      end

      within "#disabled_items" do
        expect(page).to have_button("Enable")

        click_button("Enable", id: "enable_button#{@item_3.id}")
        expect(current_path).to eq(merchant_items_path(@merchant_1))
      end
    end
  end

  describe "new item link" do
    before(:each) do 
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1, status: :enabled)
      @item_2 = create(:item, merchant: @merchant_1, status: :disabled)
      @item_3 = create(:item, merchant: @merchant_1, status: :disabled)
      @item_4 = create(:item, merchant: @merchant_1, status: :enabled)
    end 
    it "displays a link to create a new item" do
      visit merchant_items_path(@merchant_1)

      within "#new_item_link" do
        expect(page).to have_link("New Item")
      end
    end

    it "user clicks link and sent to new item page" do
      visit merchant_items_path(@merchant_1)
      
      within "#new_item_link" do

      click_link("New Item")
      expect(current_path).to eq(new_merchant_item_path(@merchant_1))
      end
    end
  end

  describe "Top 5 most popular items" do
    before(:each) do
      @merch1 = create(:merchant, status: 1)
      @merch2 = create(:merchant, status: 1)

      @item1 = create(:item, merchant: @merch1)
      @item2 = create(:item, merchant: @merch1)
      @item3 = create(:item, merchant: @merch1)
      @item4 = create(:item, merchant: @merch1)
      @item5 = create(:item, merchant: @merch1)
      @item6 = create(:item, merchant: @merch1)

      @invoice1 = create(:invoice)
      @invoice2 = create(:invoice)
      @invoice3 = create(:invoice)

      @invitm1 = create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 100, unit_price: 1000)
      @invitm2 = create(:invoice_item, invoice: @invoice1, item: @item2, quantity: 90, unit_price: 1000)
      @invitm3 = create(:invoice_item, invoice: @invoice1, item: @item3, quantity: 40, unit_price: 1000)
      @invitm4 = create(:invoice_item, invoice: @invoice2, item: @item4, quantity: 90, unit_price: 1000)
      @invitm5 = create(:invoice_item, invoice: @invoice2, item: @item5, quantity: 50, unit_price: 1000)
      @invitm6 = create(:invoice_item, invoice: @invoice2, item: @item6, quantity: 90, unit_price: 1000)
      @invitm7 = create(:invoice_item, invoice: @invoice3, item: @item1, quantity: 90, unit_price: 1000)
      @invitm8 = create(:invoice_item, invoice: @invoice3, item: @item2, quantity: 20, unit_price: 1000)
      @invitm9 = create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 10, unit_price: 1000)
      @invitm10 = create(:invoice_item, invoice: @invoice3, item: @item4, quantity: 5, unit_price: 1000)
      @invitm11 = create(:invoice_item, invoice: @invoice3, item: @item5, quantity: 30, unit_price: 1000)
      @invitm12 = create(:invoice_item, invoice: @invoice3, item: @item6, quantity: 70, unit_price: 1000)

      @transaction1 = create(:transaction, invoice: @invoice1, result: "success")
      @transaction2 = create(:transaction, invoice: @invoice2, result: "success")
      @transaction3 = create(:transaction, invoice: @invoice3, result: "success")
    end

    it "displays the names of the top 5 most popular items ranked by total revenue" do
      visit merchant_items_path(@merch1)

      within "#top_items" do
        expect(page).to have_content("Top 5 Items")
        expect(@item1.name).to appear_before(@item6.name)
        expect(@item6.name).to appear_before(@item2.name)
        expect(@item2.name).to appear_before(@item4.name)
        expect(@item4.name).to appear_before(@item5.name)
        expect(@item5.name).to_not appear_before(@item1.name)
        expect(page).to_not have_content(@item3.name)
        expect(page).to have_link(@item1.name)
        expect(page).to have_link(@item6.name)
        expect(page).to have_link(@item2.name)
        expect(page).to have_link(@item4.name)
        expect(page).to_not have_link(@item3.name)
      end
    end
  end
end