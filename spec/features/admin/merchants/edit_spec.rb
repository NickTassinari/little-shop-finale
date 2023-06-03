require 'rails_helper'

RSpec.describe "Admin Merchant Edit Form", type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end

  describe "On the edit merchant form" do
    it "has the existing merchant attribute information" do
      visit edit_admin_merchant_path(@merchant_1)
      
      expect(page).to have_content("#{@merchant_1.name} Edit Page")
      expect(page).to have_field('Name', with: @merchant_1.name)
    end
    
    it "can update merchant information and confirm the update" do
      visit edit_admin_merchant_path(@merchant_1)
      fill_in("Name", with: "Jim Bob's")
      click_button("Submit")

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
      expect(page).to have_content("Jim Bob's")
      expect(page).to have_content("Jim Bob's was successfully updated")
    end

    it "will re-render the edit form if fields are left blank" do
      visit edit_admin_merchant_path(@merchant_2)
      fill_in("Name", with: "" )
      click_button("Submit")

      expect(current_path).to eq(edit_admin_merchant_path(@merchant_2))
      expect(page).to have_content("Merchant must have a name")
    end
  end
end