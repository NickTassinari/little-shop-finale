require "rails_helper"

RSpec.describe "Merchants Coupon Page" do 
  before(:each) do 
    @merchant = Merchant.create!(name: "Ricky's Used Crap")
    @coupon_1 = Coupon.create!(name: "BOGO 25% OFF", discount_type: "percentage", discount: 25, coupon_code: "Juneteenthbogo", merchant_id: @merchant.id, status: "active")
    @coupon_2 = Coupon.create!(name: "BOGO 40% OFF", discount_type: "percentage", discount: 40, coupon_code: "Independencebogo", merchant_id: @merchant.id, status: "active")
    @coupon_3 = Coupon.create!(name: "BOGO 50% OFF", discount_type: "percentage", discount: 50, coupon_code: "Laborbogo", merchant_id: @merchant.id, status: "active")
    @coupon_4 = Coupon.create!(name: "Twenty whole dollars OFF", discount_type: "dollars", discount: 20, coupon_code: "twentybills", merchant_id: @merchant.id, status: "active")
  end

  it "has coupons attributes listed" do 
    visit "/merchants/#{@merchant.id}/coupons/#{@coupon_1.id}"

    expect(page).to have_content("Name: #{@coupon_1.name}")
    expect(page).to have_content("Code: #{@coupon_1.coupon_code}")
    expect(page).to have_content("Discount Value: #{@coupon_1.discount}")
    expect(page).to have_content("Status: #{@coupon_1.status}")
    expect(page).to have_content("Coupon Use Count: #{@coupon_1.times_used}")
  end

  it "has a button to deactivate coupon" do 
    visit "/merchants/#{@merchant.id}/coupons/#{@coupon_1.id}"

    click_button "Deactivate #{@coupon_1.name}"

    expect(current_path).to eq("/merchants/#{@merchant.id}/coupons/#{@coupon_1.id}")
    expect(page).to have_content("Status: deactivated")
  end
end