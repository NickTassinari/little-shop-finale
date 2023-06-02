require "rails_helper"

RSpec.describe "Merchant Items Show Page" do


  describe "Merchant Items Show Page Display", type: :feature do
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

      click_link(@item_1.name)
      # save_and_open_page

      expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.unit_price)
    end

    #User Story 8
    it "displays link to update item" do
      visit merchant_item_path(@merchant_1, @item_1)
      save_and_open_page

      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.unit_price)
      expect(page).to have_link("Update #{@item_1.name}")
      expect(page).to_not have_content(@item_2.name)
    end

    it "when visitor clicks link they're taken to the edit page, it displays a form filled in with existing item info" do
      visit merchant_item_path(@merchant_1, @item_1)
      click_link("Update #{@item_1.name}")

      expect(current_path).to eq(edit_merchant_item_path(@merchant_1, @item_1))
    end
  end
end