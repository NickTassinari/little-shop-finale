require "rails_helper" 

RSpec.describe "Coupon Index Page" do 
  before(:each) do 
    @merchant = Merchant.create!(name: "Ricky's Used Crap")
    @coupon_1 = Coupon.create!(name: "BOGO 25% OFF", discount_type: "percentage", discount: 25, coupon_code: "Juneteenthbogo", merchant_id: @merchant.id, status: "active")
    @coupon_2 = Coupon.create!(name: "BOGO 40% OFF", discount_type: "percentage", discount: 40, coupon_code: "Independencebogo", merchant_id: @merchant.id, status: "active")
    @coupon_3 = Coupon.create!(name: "BOGO 50% OFF", discount_type: "percentage", discount: 50, coupon_code: "Laborbogo", merchant_id: @merchant.id, status: "active")
    @coupon_4 = Coupon.create!(name: "Twenty whole dollars OFF", discount_type: "dollars", discount: 20, coupon_code: "twentybills", merchant_id: @merchant.id, status: "active")
    @coupon_5 = Coupon.create!(name: "Forget About It Fridays", discount_type: "dollars", discount: 40, coupon_code: "Gabagool", merchant_id: @merchant.id, status: "active")
  end
  #user story 1
  it "displays name and discount amount for each coupon" do 
    visit merchant_coupons_path(@merchant)

    within("#coupon-#{@coupon_1.id}") do 
      expect(page).to have_content("BOGO 25% OFF")
      expect(page).to have_content("Discount Amount: 25%")
    end

    within("#coupon-#{@coupon_4.id}") do 
      expect(page).to have_content("Twenty whole dollars OFF")
      expect(page).to have_content("Discount Amount: $20")
    end

    within("#coupon-#{@coupon_5.id}") do 
      expect(page).to have_content("Forget About It Fridays")
      expect(page).to have_content("Discount Amount: $40")
    end
  end 

  it "has a link to coupon show page that is the coupons name" do 
    
    visit merchant_coupons_path(@merchant)
    within("#coupon-#{@coupon_1.id}") do 
      click_link "#{@coupon_1.name}"
    end
    expect(current_path).to eq("/merchants/#{@merchant.id}/coupons/#{@coupon_1.id}")

    visit merchant_coupons_path(@merchant)

    within("#coupon-#{@coupon_2.id}") do 
      click_link "#{@coupon_2.name}"
    end
    expect(current_path).to eq("/merchants/#{@merchant.id}/coupons/#{@coupon_2.id}")
  end

  it "has a link to create a new coupon" do 
    visit merchant_coupons_path(@merchant)

    expect(page).to have_link "Create New Coupon"
    click_link "Create New Coupon"
    expect(current_path).to eq(new_merchant_coupon_path(@merchant))
  end

  it "displays coupons seperated between active and inactive" do 
    @coupon_6 = Coupon.create!(name: "Paisano discount", discount_type: "dollars", discount: 40, coupon_code: "SpaghettiMarinar", merchant_id: @merchant.id, status: "deactivated")
    visit merchant_coupons_path(@merchant)

    within("#active-coupons") do 
      expect(page).to have_content("#{@coupon_1.name}") 
      expect(page).to have_content("#{@coupon_2.name}") 
      expect(page).to have_content("#{@coupon_3.name}") 
      expect(page).to have_content("#{@coupon_4.name}") 
      expect(page).to have_content("#{@coupon_5.name}") 
      expect(page).to_not have_content(@coupon_6.name)
    end

    within("#deactivated-coupons") do 
      expect(page).to have_content(@coupon_6.name)
      expect(page).to_not have_content(@coupon_1.name)
      expect(page).to_not have_content(@coupon_2.name)
      expect(page).to_not have_content(@coupon_3.name)
      expect(page).to_not have_content(@coupon_4.name)
      expect(page).to_not have_content(@coupon_5.name)
    end
  end

  it "displays the next three holidays" do 
    visit merchant_coupons_path(@merchant)
    expect(page).to have_content("Upcoming Holidays")
    expect(page).to have_content("Juneteenth")
    expect(page).to have_content("Independence Day")
    expect(page).to have_content("Labor Day")

  end
end 
