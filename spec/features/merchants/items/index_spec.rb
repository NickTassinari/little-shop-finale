require "rails_helper"

RSpec.describe "Merchant Items Index Page" do


  describe "Merchant Items Index Display", type: :feature do
    before(:each) do 
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1) 
      @item_3 = create(:item, merchant: @merchant_2) 
    end
    # User Story 6
    it "displays a list of the names of all my items" do
      visit merchant_items_path(@merchant_1) 

      expect(page).to have_content("My Items")
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
    end
    #User Story 7
    it "display link of items name, redirects to merchant items show page" do
    visit merchant_items_path(@merchant_1)

    click_link @item_1.name

    expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
    end
  end
end