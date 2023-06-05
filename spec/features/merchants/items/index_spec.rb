require "rails_helper"

RSpec.describe "Merchant Items Index Page" do
  describe "Merchant Items Index Display", type: :feature do
    before(:each) do 
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1) 
      @item_3 = create(:item, merchant: @merchant_2) 
      @item_4 = create(:item, merchant: @merchant_2) 
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

    #User Story 9
    it "displays next to each item name a button to disable or enable the item" do
      visit merchant_items_path(@merchant_2)
      
      within "#item-#{@item_3.id}" do
        expect(page).to have_button("Disable")
        expect(page).to have_button("Enable")
        expect(page).to have_content("pending")
      end
      
      within "#item-#{@item_4.id}" do
        expect(page).to have_button("Disable")
        expect(page).to have_button("Enable")
        expect(page).to have_content("pending")
      end
    end
    
    it "when user clicks button they are redirected back to the items index, see items status change" do
      visit merchant_items_path(@merchant_2)
      within "#item-#{@item_3.id}" do
        click_button("Enable")

        expect(current_path).to eq(merchant_items_path(@merchant_2))
        expect(page).to have_content("enabled")
      end

      visit merchant_items_path(@merchant_1)
      within "#item-#{@item_1.id}" do
        click_button("Disable")
      
        expect(current_path).to eq(merchant_items_path(@merchant_1))
        expect(page).to have_content("disabled")
      end
    end
  end
end