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

      new_merchant = Merchant.where(name: 'Really Good Stuff')
      within "#disabled_merchants" do
        expect(page).to have_content("Really Good Stuff")
        expect(page).to have_link("Enable #{new_merchant.name}")
      end
    end
  end
end