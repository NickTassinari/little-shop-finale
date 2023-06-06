require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "Relationships" do
    it { should belong_to(:merchant)}
    it { should have_many(:invoice_items)}
    it { should have_many(:invoices).through(:invoice_items)}
  end

  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe "Class Methods" do
    before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1, status: :enabled)
    @item_2 = create(:item, merchant: @merchant_1, status: :disabled)
    @item_3 = create(:item, merchant: @merchant_1, status: :disabled)
    end

    describe ".enabled_items" do
      it "groups items by enabled status" do
        expect(Item.enabled_items).to eq([@item_1])
      end

    end

    describe ".disabled_items" do
      it "groups items by disabled status" do
        expect(Item.disabled_items).to eq([@item_2, @item_3])
      end

    end
  end
end