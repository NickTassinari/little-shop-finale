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

  describe "Instance methods" do
    before(:each) do 
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1) 
      @item_3 = create(:item, merchant: @merchant_2) 
    end

    describe "#enable!" do
      it "updates the status to enabled" do
        @item_1.enable!

        expect(@item_1.status).to eq("enabled")
      end
    end

    describe "#disable!" do
      it "updates the status to disabled" do
        @item_2.disable!

        expect(@item_2.status).to eq("disabled")
      end
    end
  end
end