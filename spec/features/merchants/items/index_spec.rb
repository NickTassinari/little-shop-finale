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
#     9. Merchant Item Disable/Enable

# As a merchant
# When I visit my items index page (/merchants/:merchant_id/items)
# Next to each item name I see a button to disable or enable that item.
# When I click this button
# Then I am redirected back to the items index
# And I see that the items status has changed
    it "displays next to each item name a button to disable or enable the item" do
      visit merchant_items_path(@merchant_2)
      
      within "#item-#{@item_3.id}" do
        expect(page).to have_button("Disable")
        expect(page).to have_button("Enable")
      end
      
      within "#item-#{@item_4.id}" do
        expect(page).to have_button("Disable")
        expect(page).to have_button("Enable")
      end
    end
    
    it "when user clicks button they are redirected back to the items index, see items status change" do
      visit merchant_items_path(@merchant_2)
      within "#item-#{@item_3.id}" do
        save_and_open_page
        click_button("Enable")

       

        expect(current_path).to eq(merchant_items_path(@merchant_2))
        expect(page).to have_button("Disable")
      end

      visit merchant_items_path(@merchant_1)
      
      within "#item-#{@item_1.id}" do
        click_button("Disable")
      
        expect(current_path).to eq(merchant_items_path(@merchant_1))
        expect(page).to have_button("Enable")
      end
    end
  end
end