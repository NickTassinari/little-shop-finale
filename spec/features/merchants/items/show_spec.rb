require "rails_helper"

RSpec.describe "Merchant Items Show Page" do


  describe "Merchant Items Show Display", type: :feature do
    before(:each) do 
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1) 
      @item_3 = create(:item, merchant: @merchant_2) 
    end

    #User Story 7
    it "displays all attributes of the item" do
      visit merchant_items_path(@merchant_1)

      click_link @item_1.name

      expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.unit_price)
    end
  end
end