require 'rails_helper'

RSpec.describe "Admin Merchant New Form", type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end

  describe "Creating a new merchant" do
    it "can fill out the new merchant form and submit" do
      visit new_admin_merchant_path
      
      expect(page).to have_content("New Merchant Form")
      expect(page).to have_field("Name")
      
      fill_in("Name", with: "Really Good Stuff")
      click_button("Submit")
      
      expect(current_path).to eq(admin_merchants_path)
      
      within "#disabled_merchants" do
        @rgs = Merchant.last
        
        expect(page).to have_content("#{@rgs.name}")
        expect(page).to have_button("Enable #{@rgs.name}")
      end
      expect(page).to have_content("Really Good Stuff was successfully created")
    end
  end
  
  describe "Sad Path - merchant requires a name to be created" do
    it "will re-render the new merchant form if not filled out correctly" do
      visit new_admin_merchant_path
      # save_and_open_page
      # fill_in("Name", with: "")
      click_button("Submit")

      expect(current_path).to eq(new_admin_merchant_path)
      expect(page).to have_content("Please enter a merchant name")
    end
  end
end