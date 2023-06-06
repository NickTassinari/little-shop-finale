require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "Relationships" do
    it { should have_many(:items)}
    it { should have_many(:invoice_items).through(:items)}
    it { should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:customers).through(:invoices)}
    it { should have_many(:transactions).through(:invoices)}
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

    it "#best_day" do
      top_merch_data

      expect(@merch1.top_day).to eq(@invoice1.created_at.to_date)
      expect(@merch6.top_day).to eq(@invoice2.created_at.to_date)
      expect(@merch2.top_day).to eq(@invoice1.created_at.to_date)
      expect(@merch4.top_day).to eq(@invoice2.created_at.to_date)
      expect(@merch5.top_day).to eq(@invoice2.created_at.to_date)
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