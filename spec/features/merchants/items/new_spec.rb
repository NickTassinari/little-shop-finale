require "rails_helper"

RSpec.describe "Merchant Items New Page" do
  describe "Merchant Items New Item Creatation", type: :feature do
    before(:each) do 
      @merchant_1 = create(:merchant)
      # @item_1 = create(:item, merchant: @merchant_1, status: :enabled)
    end

    #US 11
    it "displays an empty form to create a new item" do
      visit new_merchant_item_path(@merchant_1)
      # save_and_open_page
      
      expect(page).to have_content("Create New Item")
      expect(page).to have_field("Name")
      expect(page).to have_field("Description")
      expect(page).to have_field("Current Price")
      expect(page).to have_button("Submit")
    end
    
    it "user can fill out form to create a new item, click submit redirecting to the items index page" do
      visit new_merchant_item_path(@merchant_1)
      fill_in 'Name', with: 'Shiny New Item'
      fill_in 'Description', with: 'Super Duper Shiny'
      fill_in 'Current Price', with: 20000

      click_button("Submit")

      expect(current_path).to eq(merchant_items_path(@merchant_1))
      expect(page).to have_content("Item created successfully")
      within "#disabled_items" do
        expect(page).to have_button("Enable")
        expect(page).to have_content("Shiny New Item")
      end
    end
    it "re renders the item edit page if the form is not filled out completely" do
      visit new_merchant_item_path(@merchant_1)
      fill_in 'Name', with: ''
      fill_in 'Description', with: 'Super Duper Shiny'
      fill_in 'Current Price', with: 20000

      click_button("Submit")

      expect(current_path).to eq(new_merchant_item_path(@merchant_1))
      expect(page).to have_content("Item creation failed")
    end
  end
end