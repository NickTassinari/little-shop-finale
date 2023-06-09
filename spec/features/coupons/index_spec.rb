require "rails_helper" 

RSpec.describe "Coupon Index Page" do 
  before(:each) do 
    @merchant = Merchant.create!(name: "Ricky's Used Crap")
    @coupon_1 = Coupon.create!(name: "BOGO 25% OFF", discount_type: "percentage", discount: 25, coupon_code: "Juneteenthbogo", merchant_id: @merchant.id)
    @coupon_2 = Coupon.create!(name: "BOGO 40% OFF", discount_type: "percentage", discount: 40, coupon_code: "Independencebogo", merchant_id: @merchant.id)
    @coupon_3 = Coupon.create!(name: "BOGO 50% OFF", discount_type: "percentage", discount: 50, coupon_code: "Laborbogo", merchant_id: @merchant.id)
    @coupon_4 = Coupon.create!(name: "Twenty whole dollars OFF", discount_type: "dollars", discount: 20, coupon_code: "twentybills", merchant_id: @merchant.id)
    @coupon_5 = Coupon.create!(name: "Forget About It Fridays", discount_type: "dollars", discount: 40, coupon_code: "Gabagool", merchant_id: @merchant.id)
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
end