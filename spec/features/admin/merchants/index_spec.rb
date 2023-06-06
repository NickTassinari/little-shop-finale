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
  
  describe "link to create a new merchant" do
    it "can click that leads to the form to create a new merchant" do
      visit admin_merchants_path

      expect(page).to have_link("New Merchant")

      click_link("New Merchant")
      expect(current_path).to eq(new_admin_merchant_path)
    end
  end

  describe "top 5 merchants" do
    it "can display names of top 5 merchants by total revenue" do
      top_merch_data
      visit admin_merchants_path
      
      within "#top_merchants" do
        expect(page).to have_content("Top 5 Merchants")
        expect(@merch1.name).to appear_before(@merch6.name)
        expect(@merch6.name).to appear_before(@merch2.name)
        expect(@merch2.name).to appear_before(@merch4.name)
        expect(@merch4.name).to appear_before(@merch5.name)
        expect(@merch5.name).to_not appear_before(@merch1.name)
        expect(page).to_not have_content(@merch3.name)
        expect(page).to have_link(@merch1.name)
        expect(page).to have_link(@merch6.name)
        expect(page).to_not have_link(@merch3.name)
      end
    end
  end
  
  describe "top merchants best day" do
    it "displays the best day for each of the top five merchants" do
      top_merch_data
      visit admin_merchants_path
      within "#top_merchants" do
        expect(page).to have_content(@merch1.name)
        expect(page).to have_content("$1,900.00")
        expect(page).to have_content(@merch6.name)
        expect(page).to have_content("1,600.00")
        expect("$1,900.00").to appear_before("1,600.00")
        expect(page).to have_content("Top selling date for #{@merch1.name} was #{@merch1.best_day.strftime('%B %d, %Y')}")
        expect(page).to have_content("Top selling date for #{@merch6.name} was #{@merch6.best_day.strftime('%B %d, %Y')}")
      end
    end
  end
end