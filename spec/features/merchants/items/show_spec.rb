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
#     # it "display a link to update the item information" do
    #   visit merchant_items_path(@merchant_1, @item_1)

    #   expect(page).to have_link("Update Item Information")
    #   expect(page).to_not have_content(@item_2.name)
    # end

    it "when user clicks link, redirects to a page to edit item" do
      visit merchant_item_path(@merchant_1, @item_1)
      save_and_open_page

      click_link("Update #{@item_1.name}")

    end

    it "displays a form filled in with existing information" do


    end

    it "when user updates information in form and clicks 'submit' button, redirects back to the item show page with updated info" do

    end

    it "displays a flash message stating the information was updated succssfully" do

    end

    
  end
end