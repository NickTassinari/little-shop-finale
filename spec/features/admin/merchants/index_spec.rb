require 'rails_helper'

RSpec.describe "Admin Merchant Index Page", type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant, status: 0)
    @merchant_2 = create(:merchant, status: 1)
    @merchant_3 = create(:merchant, status: 0)
    @merchant_4 = create(:merchant, status: 1)
    @merchant_5 = create(:merchant, status: 1)
  end

  describe "When I visit the admin merchants index" do
    it "displays the name of each merchant in the system" do
      visit admin_merchants_path
      
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
    end
    
    it "each merchant name is a link to that merchant's show page" do
      visit admin_merchants_path
      
      expect(page).to have_link(@merchant_1.name)
      expect(page).to have_link(@merchant_2.name)
      
      click_link(@merchant_1.name)
      expect(current_path).to eq(admin_merchant_path(@merchant_1))
    end
  end
  
  describe "Sections for Disabling and Enabling Merchants" do
    it "has a section for enabled merchants with a button to disable that merchant" do
      visit admin_merchants_path

      within "#enabled_merchants" do
        expect(page).to have_button("Disable #{@merchant_2.name}")
  
        click_button("Disable #{@merchant_2.name}")
        expect(current_path).to eq(admin_merchants_path)
      end
      expect(page).to have_button("Enable #{@merchant_2.name}")
    end

    it "has a section for disabled merchants with a button to enable that merchant" do
      visit admin_merchants_path

      within "#disabled_merchants" do
        expect(page).to have_button("Enable #{@merchant_1.name}")

        click_button("Enable #{@merchant_1.name}")
        expect(current_path).to eq(admin_merchants_path)
      end
      expect(page).to have_button("Disable #{@merchant_2.name}")
    end
  end
end