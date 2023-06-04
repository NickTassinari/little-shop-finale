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
  end
end