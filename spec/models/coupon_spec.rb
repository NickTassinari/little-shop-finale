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

    it "#times_used" do 
      @item_1 = Item.create!(name: "Pepperoni", description: "Spicy boi", merchant: @merchant, unit_price: 2000)
      @custie_1 = Customer.create!(first_name: "Terry", last_name: "Tromboli")
      @custie_2 = Customer.create!(first_name: "Tony", last_name: "Tramberelli")
      @invoice_1 = Invoice.create!(customer_id: @custie_1.id, status: 2, coupon_id: @coupon_5.id)
      @invoice_2 = Invoice.create!(customer_id: @custie_1.id, status: 2, coupon_id: @coupon_5.id)
      @invoice_3 = Invoice.create!(customer_id: @custie_1.id, status: 2, coupon_id: @coupon_5.id)
      @invoice_4 = Invoice.create!(customer_id: @custie_2.id, status: 2, coupon_id: @coupon_4.id)
      @invoice_item_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 2000, status: 2)
      @invoice_item_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 10, unit_price: 2000, status: 2)
      @invoice_item_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_1.id, quantity: 10, unit_price: 2000, status: 2)
      @invoice_item_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_1.id, quantity: 10, unit_price: 2000, status: 2)
      @transaction_1 = create(:transaction, result: "success", invoice_id: @invoice_1.id)
      @transaction_2 = create(:transaction, result: "success", invoice_id: @invoice_2.id)
      @transaction_3 = create(:transaction, result: "success", invoice_id: @invoice_3.id)
      @transaction_4 = create(:transaction, result: "success", invoice_id: @invoice_4.id)

      expect(@coupon_5.times_used).to eq(3)
      expect(@coupon_4.times_used).to eq(1)

    end
  end
end