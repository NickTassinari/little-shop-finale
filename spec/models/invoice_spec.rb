require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "Relationships" do
    it { should belong_to(:customer)}
    it { should have_many(:transactions)}
    it { should have_many(:invoice_items)}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:merchants).through(:items)}
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
  end
end