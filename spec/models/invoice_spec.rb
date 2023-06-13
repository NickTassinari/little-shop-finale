require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "Relationships" do
    it { should belong_to(:customer)}
    it { should have_many(:transactions)}
    it { should have_many(:invoice_items)}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:merchants).through(:items)}
    it { should belong_to(:coupon).optional }

  end

  describe "Validations" do 
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end

  before(:each) do
    @merchant_1 = create(:merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @item_1 = create(:item, merchant: @merchant_1)
    @invoice_1 = @customer_1.invoices.create!(status: 1)
    @invoice_2 = @customer_1.invoices.create!(status: 1)
    @invoice_3 = @customer_2.invoices.create!(status: 1)
    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, status: 0, quantity: 10, unit_price: 100)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, status: 2, quantity: 20, unit_price: 50)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_3.id, status: 2, quantity: 2, unit_price: 1000)
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_3.id, status: 1, quantity: 5, unit_price: 500)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, status: 1, quantity: 1, unit_price: 100)
  end

  describe "Class Methods" do
    describe "#incomplete_invoices" do
      it "returns the invoices with items that have not been shipped" do
        expect(Invoice.incomplete_invoices).to include(@invoice_1, @invoice_3)
        expect(Invoice.incomplete_invoices).to_not include(@invoice_2)
      end
    end
  end

  describe "Instance Methods" do
    describe "#total_revenue" do
      it "returns the total revenue for an invoice" do
        expect(@invoice_1.total_revenue).to eq(1100)
        expect(@invoice_2.total_revenue).to eq(1000)
        expect(@invoice_3.total_revenue).to eq(4500)
      end
    end

    describe "grand total" do 
      it "dollar amount" do 
        @merchant_3 = create(:merchant)
        @item_9 = create(:item, merchant: @merchant_3, unit_price: 2000)
        @customer_7 = create(:customer)
        @coupon_1 = Coupon.create!(name: "BOGO $25 OFF", discount_type: "dollar", discount: 25, coupon_code: "Juneteenthbogo", merchant_id: @merchant_3.id, status: "active")
        @invoice_7 = create(:invoice, customer: @customer_7, coupon_id: @coupon_1.id)
        @invoice_item_7 = create(:invoice_item, quantity: 1, unit_price: @item_9.unit_price, item_id: @item_9.id, invoice_id: @invoice_7.id)
        @transaction_4 = create(:transaction, result: "success", invoice: @invoice_7)
        @transaction_5 = create(:transaction, result: "success", invoice: @invoice_7)
        @transaction_6 = create(:transaction, result: "success", invoice: @invoice_7)

        expect(@invoice_7.grand_total).to eq(1975)
      end

      it "percent amount" do 
        @merchant_4 = create(:merchant)
        @item_10 = create(:item, merchant: @merchant_4, unit_price: 2000)
        @customer_8 = create(:customer)
        @coupon_2 = Coupon.create!(name: "Everything 50% off", discount_type: "percentage", discount: 50, coupon_code: "ToyotaThon", merchant_id: @merchant_4.id, status: "active")
        @invoice_8 = create(:invoice, customer: @customer_8, coupon_id: @coupon_2.id)
        @invoice_item_8 = create(:invoice_item, quantity: 1, unit_price: @item_10.unit_price, item_id: @item_10.id, invoice_id: @invoice_8.id)
        @transaction_7 = create(:transaction, result: "success", invoice: @invoice_8)
        @transaction_8 = create(:transaction, result: "success", invoice: @invoice_8)
        @transaction_9 = create(:transaction, result: "success", invoice: @invoice_8)

        expect(@invoice_8.grand_total).to eq(1000)
      end

      it "tests if there is no coupon" do 
        @merchant_5 = create(:merchant)
        @item_11 = create(:item, merchant: @merchant_5, unit_price: 2000)
        @customer_9 = create(:customer)
        @invoice_9 = create(:invoice, customer: @customer_9)
        @invoice_item_8 = create(:invoice_item, quantity: 1, unit_price: @item_11.unit_price, item_id: @item_11.id, invoice_id: @invoice_9.id)
        @transaction_10 = create(:transaction, result: "success", invoice: @invoice_9)
        @transaction_11 = create(:transaction, result: "success", invoice: @invoice_9)
        @transaction_12 = create(:transaction, result: "success", invoice: @invoice_9)

        expect(@invoice_9.grand_total).to eq(@invoice_9.total_revenue)
      end

      it "tests if coupon amount is greater than grand total and return 0" do 
        @merchant_5 = create(:merchant)
        @item_11 = create(:item, merchant: @merchant_5, unit_price: 2000)
        @coupon_2 = Coupon.create!(name: "Everything 50% off", discount_type: "dollar", discount: 2500, coupon_code: "ToyotaThon", merchant_id: @merchant_5.id, status: "active")
        @customer_9 = create(:customer)
        @invoice_9 = create(:invoice, customer: @customer_9, coupon_id: @coupon_2.id)
        @invoice_item_8 = create(:invoice_item, quantity: 1, unit_price: @item_11.unit_price, item_id: @item_11.id, invoice_id: @invoice_9.id)
        @transaction_10 = create(:transaction, result: "success", invoice: @invoice_9)
        @transaction_11 = create(:transaction, result: "success", invoice: @invoice_9)
        @transaction_12 = create(:transaction, result: "success", invoice: @invoice_9)
     
        expect(@invoice_9.grand_total).to eq(0)
      end
    end
  end
end