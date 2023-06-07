require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "Relationships" do
    it { should belong_to(:merchant)}
    it { should have_many(:invoice_items)}
    it { should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:transactions).through(:invoices)}
  end
    
  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  before(:each) do
    @merchant_1 = create(:merchant)
    @customer_1 = create(:customer)
    @item_1 = create(:item, merchant: @merchant_1, status: :enabled)
    @item_2 = create(:item, merchant: @merchant_1, status: :disabled)
    @item_3 = create(:item, merchant: @merchant_1, status: :disabled)
    @item_4 = create(:item, merchant: @merchant_1, status: :enabled)
    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_1)
    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, status: 1, quantity: 10, unit_price: 100)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, status: 1, quantity: 20, unit_price: 50)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id, status: 0, quantity: 2, unit_price: 1000)
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_1.id, status: 2, quantity: 5, unit_price: 500)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, status: 1, quantity: 1, unit_price: 100)
    @invoice_item_6 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_2.id, status: 1, quantity: 10, unit_price: 500)
  end

  describe "Instance Methods" do
    describe "#num_sold" do
      it "find the number of items sold on a specific invoice" do
        expect(@item_1.num_sold(@invoice_1)).to eq(@invoice_item_1.quantity)
        expect(@item_1.num_sold(@invoice_2)).to eq(@invoice_item_5.quantity)
        expect(@item_2.num_sold(@invoice_1)).to eq(@invoice_item_2.quantity)
        expect(@item_3.num_sold(@invoice_1)).to eq(@invoice_item_3.quantity)
      end
    end

    describe "#unit_price" do
      it "find the unit price of an item on a specific invoice" do
        expect(@item_1.price_sold(@invoice_1)).to eq(@invoice_item_1.unit_price)
        expect(@item_1.price_sold(@invoice_2)).to eq(@invoice_item_5.unit_price)
        expect(@item_2.price_sold(@invoice_1)).to eq(@invoice_item_2.unit_price)
        expect(@item_4.price_sold(@invoice_2)).to eq(@invoice_item_6.unit_price)
      end
    end

    describe "#invoice_status" do
      it "find the status of an item on a specific invoice" do
        expect(@item_1.invoice_status(@invoice_1)).to eq(@invoice_item_1.status)
        expect(@item_1.invoice_status(@invoice_2)).to eq(@invoice_item_5.status)
        expect(@item_2.invoice_status(@invoice_1)).to eq(@invoice_item_2.status)
        expect(@item_4.invoice_status(@invoice_2)).to eq(@invoice_item_6.status)
      end
    end
  end

  describe "Class Methods" do
    describe ".enabled_items" do
      it "groups items by enabled status" do
        expect(Item.enabled_items.to_a).to eq([@item_1, @item_4])
      end
    end

    describe ".disabled_items" do
      it "groups items by disabled status" do
        expect(Item.disabled_items.to_a).to eq([@item_2, @item_3])
      end
    end

    describe ".top_five_items" do
      before(:each) do
        @merch1 = create(:merchant, status: 1)

        @item1 = create(:item, merchant: @merch1)
        @item2 = create(:item, merchant: @merch1)
        @item3 = create(:item, merchant: @merch1)
        @item4 = create(:item, merchant: @merch1)
        @item5 = create(:item, merchant: @merch1)
        @item6 = create(:item, merchant: @merch1)

        @invoice1 = create(:invoice)
        @invoice2 = create(:invoice)
        @invoice3 = create(:invoice)

        @invitm1 = create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 100, unit_price: 1000)
        @invitm2 = create(:invoice_item, invoice: @invoice1, item: @item2, quantity: 90, unit_price: 1000)
        @invitm3 = create(:invoice_item, invoice: @invoice1, item: @item3, quantity: 40, unit_price: 1000)
        @invitm4 = create(:invoice_item, invoice: @invoice2, item: @item4, quantity: 90, unit_price: 1000)
        @invitm5 = create(:invoice_item, invoice: @invoice2, item: @item5, quantity: 50, unit_price: 1000)
        @invitm6 = create(:invoice_item, invoice: @invoice2, item: @item6, quantity: 90, unit_price: 1000)
        @invitm7 = create(:invoice_item, invoice: @invoice3, item: @item1, quantity: 90, unit_price: 1000)
        @invitm8 = create(:invoice_item, invoice: @invoice3, item: @item2, quantity: 20, unit_price: 1000)
        @invitm9 = create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 10, unit_price: 1000)
        @invitm10 = create(:invoice_item, invoice: @invoice3, item: @item4, quantity: 5, unit_price: 1000)
        @invitm11 = create(:invoice_item, invoice: @invoice3, item: @item5, quantity: 30, unit_price: 1000)
        @invitm12 = create(:invoice_item, invoice: @invoice3, item: @item6, quantity: 70, unit_price: 1000)

        @transaction1 = create(:transaction, invoice: @invoice1, result: "success")
        @transaction2 = create(:transaction, invoice: @invoice2, result: "success")
        @transaction3 = create(:transaction, invoice: @invoice3, result: "success")
      end

      it "returns the top 5 items by total revenue" do
        expect(@merch1.items.top_five_items.to_a).to match_array([@item1, @item6, @item2, @item4, @item5])
      end
    end
  end
end