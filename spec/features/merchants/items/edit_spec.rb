require "rails_helper"

RSpec.describe "Merchant Items Edit Page" do


  describe "Merchant Items Edit Page Display", type: :feature do
    before(:each) do 
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_2) 
    end

# 8. Merchant Item Update

# As a merchant,
# When I visit the merchant show page of an item (/merchants/:merchant_id/items/:item_id)
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item
# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.
# 
    it "has existing item information" do
      visit edit_merchant_item_path(@merchant_1, @item_1)
      
      expect(page).to have_content("Item Edit Page")
      expect(page).to have_field("Name", with: @item_1.name)
      expect(page).to have_field("Description", with: @item_1.description)
      expect(page).to have_field("Current selling price", with: @item_1.unit_price)
    end
      

      

    it "when visitor updates the information in the form and clicks submit, they are redirected back to item show page that displays updated information" do  
      visit edit_merchant_item_path(@merchant_1, @item_1)
      save_and_open_page

      
      fill_in("Name", with: "Nice Chair")
      click_button("Submit")




    end

    it "displays a flash message when the information has been successfully updated" do 

    end
  end
end