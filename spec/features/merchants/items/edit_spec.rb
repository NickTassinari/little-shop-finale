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
    it "has existing item information" do
      visit edit_merchant_item_path(@merchant_1, @item_1)
      
      expect(page).to have_content("Item Edit Page")
      expect(page).to have_field("Name", with: @item_1.name)
      expect(page).to have_field("Description", with: @item_1.description)
      expect(page).to have_field("Current price", with: @item_1.unit_price)
    end
      
    it "when visitor updates the information in the form and clicks submit, they are redirected back to item show page that displays updated information" do  
      visit edit_merchant_item_path(@merchant_1, @item_1)
      
      fill_in("Name", with: "Nice Chair")
      fill_in("Description", with: "It's Nice")
      fill_in("Current price", with: 11888)
      click_button("Submit")
      
      expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
      expect(page).to have_content("Item updated successfully!")
      expect(page).to have_content("Nice Chair")
      expect(page).to have_content("It's Nice")
      expect(page).to have_content(11888)
    end

    it "displays a flash message when the form is incomplete" do 
      visit edit_merchant_item_path(@merchant_1, @item_1)

      fill_in("Name", with: "")
      fill_in("Description", with: "It's Nice")
      fill_in("Current price", with: 11888)
      click_button("Submit")

      expect(current_path).to eq(edit_merchant_item_path(@merchant_1, @item_1))
      expect(page).to have_content("Error updating item, incomplete form")
    end
  end
end