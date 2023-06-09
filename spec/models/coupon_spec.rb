require "rails_helper"

RSpec.describe Coupon, type: :model do 
  before(:each) do 
    @merchant = Merchant.create!(name: "Ricky's Used Crap")
    @coupon_1 = Coupon.create!(name: "BOGO 25% OFF", discount_type: "percentage", discount: 25, coupon_code: "Juneteenthbogo", merchant_id: @merchant.id)
    @coupon_2 = Coupon.create!(name: "BOGO 40% OFF", discount_type: "percentage", discount: 40, coupon_code: "Independencebogo", merchant_id: @merchant.id)
    @coupon_3 = Coupon.create!(name: "BOGO 50% OFF", discount_type: "percentage", discount: 50, coupon_code: "Laborbogo", merchant_id: @merchant.id)
    @coupon_4 = Coupon.create!(name: "Twenty whole dollars OFF", discount_type: "dollars", discount: 20, coupon_code: "twentybills", merchant_id: @merchant.id)
    @coupon_5 = Coupon.create!(name: "Forget About It Fridays", discount_type: "dollars", discount: 40, coupon_code: "Gabagool", merchant_id: @merchant.id)
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
    it { should have_many :invoices }
    it { should belong_to :merchant }
  end

  describe "instance methods" do 
    it "#display_discount" do 
      expect(@coupon_1.display_discount).to eq("25%")
      expect(@coupon_5.display_discount).to eq("$40")
      expect(@coupon_3.display_discount).to eq("50%")
    end
  end
end