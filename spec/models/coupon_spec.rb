require "rails_helper"

RSpec.describe Coupon, type: :model do 
  before(:each) do 
    @merchant = Merchant.create!(name: "Ricky's Used Crap")
    @coupon_1 = Coupon.create!(name: "BOGO 25% OFF", discount_type: "percentage", discount: 25, coupon_code: "Juneteenthbogo", merchant_id: @merchant.id)
    @coupon_2 = Coupon.create!(name: "BOGO 40% OFF", discount_type: "percentage", discount: 40, coupon_code: "Independencebogo", merchant_id: @merchant.id)
    @coupon_3 = Coupon.create!(name: "BOGO 50% OFF", discount_type: "percentage", discount: 50, coupon_code: "Laborbogo", merchant_id: @merchant.id)
  end

  describe "validations" do 
    it { should validate_presence_of :name }
    it { should validate_presence_of :discount_type }
    it { should validate_presence_of :discount }
    it { should validate_presence_of :coupon_code }
    it { should validate_numericality_of :discount }
    it { should validate_uniqueness_of :coupon_code }
  end

  describe "relationships" do 

  end

  describe "instance methods" do 

  end
end