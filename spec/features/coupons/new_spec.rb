require "rails_helper"

RSpec.describe "New Coupon Page" do 
  before(:each) do 
    @merchant = Merchant.create!(name: "Ricky's Used Crap")
    @coupon_1 = Coupon.create!(name: "BOGO 25% OFF", discount_type: "percentage", discount: 25, coupon_code: "Juneteenthbogo", merchant_id: @merchant.id)
    @coupon_2 = Coupon.create!(name: "BOGO 40% OFF", discount_type: "percentage", discount: 40, coupon_code: "Independencebogo", merchant_id: @merchant.id)
    @coupon_3 = Coupon.create!(name: "BOGO 50% OFF", discount_type: "percentage", discount: 50, coupon_code: "Laborbogo", merchant_id: @merchant.id)
    @coupon_4 = Coupon.create!(name: "Twenty whole dollars OFF", discount_type: "dollars", discount: 20, coupon_code: "twentybills", merchant_id: @merchant.id)
  end
  it "has a form to create new coupon" do 
    visit new_merchant_coupon_path(@merchant)

    expect(page).to have_field("Coupon Name")
    expect(page).to have_field("Coupon Code")
    expect(page).to have_field("Amount")
    expect(page).to have_field("Percent/Dollar")
    expect(page).to have_button("Submit")
  end
  # @coupon_5 = Coupon.create!(name: "Forget About It Fridays", discount_type: "dollars", discount: 40, coupon_code: "Gabagool", merchant_id: @merchant.id)
end