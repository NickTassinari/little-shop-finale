require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "Relationships" do
    it { should have_many(:items)}
    it { should have_many(:invoice_items).through(:items)}
    it { should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:customers).through(:invoices)}
    it { should have_many(:transactions).through(:invoices)}
    it { should have_many :coupons }
  end

  describe "Validations" do
    it { should validate_presence_of :name }
  end

  describe "Instance Methods" do 
    it "#top_five_customers" do
      top_customer_data
      top_custies = @merchant.top_five_customers.map { |customer| customer.first_name }

      expect(top_custies).to eq([@customer_6.first_name, @customer_5.first_name, @customer_3.first_name, @customer_4.first_name, @customer_2.first_name])
    end 

    it "#items_for_this_invoice" do 
      top_customer_data 
      expect(@merchant.items_for_this_invoice(@invoice_2.id)).to eq([@invoice_item_2])
    end

    it '#invoice_revenue' do
      top_customer_data
      expect(@merchant.invoice_revenue(@invoice_3.id)).to eq(@invoice_item_3.unit_price * @invoice_item_3.quantity)
    end

    it "#invoices_to_ship" do 
      ship_data

      expect(@merchant.invoices_to_ship).to eq([@invoice_item_1, @invoice_item_2])
    end

    it "#best_day" do
      top_merch_data
      expect(@merch1.best_day.strftime('%B %d, %Y')).to eq(@invoice1.created_at.strftime('%B %d, %Y'))
      expect(@merch6.best_day.strftime('%B %d, %Y')).to eq(@invoice2.created_at.strftime('%B %d, %Y'))
      expect(@merch2.best_day.strftime('%B %d, %Y')).to eq(@invoice1.created_at.strftime('%B %d, %Y'))
      expect(@merch4.best_day.strftime('%B %d, %Y')).to eq(@invoice2.created_at.strftime('%B %d, %Y'))
      expect(@merch5.best_day.strftime('%B %d, %Y')).to eq(@invoice2.created_at.strftime('%B %d, %Y'))
    end

    it "#active_coupons" do 
      @merchant = Merchant.create!(name: "Ricky's Used Crap")
      @coupon_1 = Coupon.create!(name: "BOGO 25% OFF", discount_type: "percentage", discount: 25, coupon_code: "Juneteenthbogo", merchant_id: @merchant.id, status: "active")
      @coupon_2 = Coupon.create!(name: "BOGO 40% OFF", discount_type: "percentage", discount: 40, coupon_code: "Independencebogo", merchant_id: @merchant.id, status: "active")
      @coupon_3 = Coupon.create!(name: "BOGO 50% OFF", discount_type: "percentage", discount: 50, coupon_code: "Laborbogo", merchant_id: @merchant.id, status: "active")
      @coupon_4 = Coupon.create!(name: "Twenty whole dollars OFF", discount_type: "dollars", discount: 20, coupon_code: "twentybills", merchant_id: @merchant.id, status: "active")

      expect(@merchant.active_coupons).to eq([@coupon_1, @coupon_2, @coupon_3, @coupon_4])
    end
  end 

  describe "Class Methods" do
    describe ".enabled_merchants" do
      it "groups merchants based on their enabled status" do
        merch_status_data
        expect(Merchant.enabled_merchants).to eq([@merchant_3, @merchant_4, @merchant_5])
      end
    end

    describe ".disabled_merchants" do
      it "groups merchants based on their disabled status" do
        merch_status_data
        expect(Merchant.disabled_merchants).to eq([@merchant_1, @merchant_2])
      end
    end

    describe ".top_5_merchants" do
      it "returns the top 5 merchants with highest total revenue" do
        top_merch_data
        expect(Merchant.top_5_merchants).to eq([@merch1, @merch6, @merch2, @merch4, @merch5])
      end
    end
  end
end