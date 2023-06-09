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
    expect(page).to have_field("Percentage/Dollar")
    expect(page).to have_button("Submit")
  end

  it "When i fill in forms with valid data I am redirected back to coupon index and see new coupon listed" do 
    visit new_merchant_coupon_path(@merchant)
    fill_in "Coupon Name", with: "Forget About It Fridays"
    fill_in "Coupon Code", with: "Gabagool"
    fill_in "Amount", with: "50"
    page.select("dollar", from: :discount_type)
    click_on "Submit"

    expect(current_path).to eq(merchant_coupons_path(@merchant))

    expect(page).to have_content("Forget About It Fridays")
    expect(page).to have_content("Discount Amount: 50")
  end

  it "can't have more than 5 active coupons" do 
    @coupon_5 = Coupon.create!(name: "Forget About It Fridays", discount_type: "dollars", discount: 40, coupon_code: "Gabagool", merchant_id: @merchant.id)
    visit new_merchant_coupon_path(@merchant)
    fill_in "Coupon Name", with: "Tony Pizzas Stromboli Discount"
    fill_in "Coupon Code", with: "Mozzarell"
    fill_in "Amount", with: "55"
    page.select("dollar", from: :discount_type)
    click_on "Submit"

    expect(current_path).to eq(new_merchant_coupon_path(@merchant))
    expect(page).to have_content("Please fill in all fields correctly Dingbat")
  end

  it "has to have a unique coupon code" do 
    visit new_merchant_coupon_path(@merchant)
    fill_in "Coupon Name", with: "Tony Pizzas Stromboli Discount"
    fill_in "Coupon Code", with: "twentybills"
    fill_in "Amount", with: "20"
    page.select("dollar", from: :discount_type)
    click_on "Submit"

    expect(current_path).to eq(new_merchant_coupon_path(@merchant))
    expect(page).to have_content("Please fill in all fields correctly Dingbat")
  end
end