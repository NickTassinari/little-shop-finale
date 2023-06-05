require "rails_helper"

RSpec.describe "Admin Dashboard Index Page" do
  before(:each) do
    @merchant_1 = create(:merchant)

    @customer_1 = create(:customer) # 6 successful transactions (via 2 invoices)
    @customer_2 = create(:customer) # 5 successful transactions
    @customer_3 = create(:customer) # 4 successful transactions
    @customer_4 = create(:customer) # 3 successful transactions
    @customer_5 = create(:customer) # 2 successful transactions (via 2 invoices)
    @customer_6 = create(:customer) # 1 successful transactions
    @customer_7 = create(:customer) # 0 successful transactions

    @invoice_1 = @customer_1.invoices.create!(status: 1)
    @invoice_2 = @customer_1.invoices.create!(status: 1)
    @invoice_3 = @customer_2.invoices.create!(status: 1)
    @invoice_4 = @customer_3.invoices.create!(status: 1)
    @invoice_5 = @customer_4.invoices.create!(status: 1)
    @invoice_6 = @customer_5.invoices.create!(status: 1)
    @invoice_7 = @customer_5.invoices.create!(status: 1)
    @invoice_8 = @customer_6.invoices.create!(status: 1)
    @invoice_9 = @customer_7.invoices.create!(status: 1)

    @transaction_1 = @invoice_1.transactions.create!(result: "success")
    @transaction_2 = @invoice_1.transactions.create!(result: "success")
    @transaction_3 = @invoice_1.transactions.create!(result: "success")
    @transaction_4 = @invoice_2.transactions.create!(result: "success")
    @transaction_5 = @invoice_2.transactions.create!(result: "success")
    @transaction_6 = @invoice_2.transactions.create!(result: "success")
    @transaction_7 = @invoice_3.transactions.create!(result: "success")
    @transaction_8 = @invoice_3.transactions.create!(result: "success")
    @transaction_9 = @invoice_3.transactions.create!(result: "success")
    @transaction_10 = @invoice_3.transactions.create!(result: "failed")
    @transaction_11 = @invoice_3.transactions.create!(result: "success")
    @transaction_12 = @invoice_3.transactions.create!(result: "success")
    @transaction_13 = @invoice_4.transactions.create!(result: "success")
    @transaction_14 = @invoice_4.transactions.create!(result: "success")
    @transaction_15 = @invoice_4.transactions.create!(result: "success")
    @transaction_16 = @invoice_4.transactions.create!(result: "success")
    @transaction_17 = @invoice_5.transactions.create!(result: "success")
    @transaction_18 = @invoice_5.transactions.create!(result: "success")
    @transaction_19 = @invoice_5.transactions.create!(result: "success")
    @transaction_20 = @invoice_6.transactions.create!(result: "success")
    @transaction_21 = @invoice_7.transactions.create!(result: "success")
    @transaction_22 = @invoice_7.transactions.create!(result: "failed")
    @transaction_23 = @invoice_8.transactions.create!(result: "success")
    @transaction_24 = @invoice_9.transactions.create!(result: "failed")

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, status: 1)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, status: 1)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, status: 0)
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_3.id, status: 2)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_4.id, status: 1)
    @invoice_item_6 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_5.id, status: 1)
    @invoice_item_7 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_6.id, status: 2)
    @invoice_item_8 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_6.id, status: 0)
  end

  describe "Admin Dashboard Display" do
    # User Story 19
    it "displays a header indicating that it is the admin dashboard" do
      visit admin_path

      expect(page).to have_content("Admin Dashboard")
    end

    # User Story 20
    it "displays a link to the admin merchants index page" do
      visit admin_path

      expect(page).to have_link("Merchants", href: admin_merchants_path)
      click_link("Merchants")
      expect(page).to have_current_path(admin_merchants_path)
    end

    it "displays a link to the admin invoices index page" do
      visit admin_path

      expect(page).to have_link("Invoices", href: admin_invoices_path)
      click_link("Invoices")
      expect(page).to have_current_path(admin_invoices_path)
    end
  end

  describe "Admin Dashboard Statistics" do
    # User Story 21
    it "displays the names and # of successful transactions for the top five costumers" do
      visit admin_path

      within("#top-five-customers") do
        expect(page).to have_content("Top Customers")

        expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name} - #{@customer_1.num_successful_transactions} purchases")
        expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name} - #{@customer_2.num_successful_transactions} purchases")
        expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name} - #{@customer_3.num_successful_transactions} purchases")
        expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name} - #{@customer_4.num_successful_transactions} purchases")
        expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name} - #{@customer_5.num_successful_transactions} purchases")
        expect(page).to_not have_content("#{@customer_6.first_name} #{@customer_6.last_name}")
        expect(page).to_not have_content("#{@customer_7.first_name} #{@customer_7.last_name}")

        expect(@customer_1.last_name).to appear_before(@customer_2.last_name)
        expect(@customer_2.last_name).to appear_before(@customer_3.last_name)
        expect(@customer_3.last_name).to appear_before(@customer_4.last_name)
        expect(@customer_4.last_name).to appear_before(@customer_5.last_name)
      end
    end
  end

  describe "Admin Dashboard Invoices" do
    # User Story 22
    it "displays the IDs of invoices that have items that have not yet been shipped" do
      visit admin_path

      within("#incomplete-invoices") do
        expect(page).to have_content("Incomplete Invoices")
        expect(page).to have_content("#{@invoice_1.id}")
        expect(page).to have_content("#{@invoice_2.id}")
        expect(page).to have_content("#{@invoice_4.id}")
        expect(page).to have_content("#{@invoice_5.id}")
        expect(page).to have_content("#{@invoice_6.id}")
        expect(page).to_not have_content("#{@invoice_3.id}")
      end
    end

    it "displays a link to each invoice's admin show page" do
      visit admin_path

      within("#incomplete-invoices") do
        expect(page).to have_link("Invoice ##{@invoice_1.id}", href: admin_invoice_path(@invoice_1))
        click_link("Invoice ##{@invoice_1.id}")
        expect(page).to have_current_path(admin_invoice_path(@invoice_1))
      end
    end

    # User Story 23
    it "displays invoices sorted by oldest to newest" do
      visit admin_path

      within("#incomplete-invoices") do
        expect("#{@invoice_6.id}").to appear_before("#{@invoice_5.id}")
        expect("#{@invoice_5.id}").to appear_before("#{@invoice_4.id}")
        expect("#{@invoice_4.id}").to appear_before("#{@invoice_2.id}")
        expect("#{@invoice_2.id}").to appear_before("#{@invoice_1.id}")
      end
    end

    it "displays the date_created next to each invoice" do
      visit admin_path

      within("#incomplete-invoices") do
        expect(page).to have_content("#{@invoice_1.id} - #{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content("#{@invoice_2.id} - #{@invoice_2.created_at.strftime("%A, %B %d, %Y")}")
      end
    end
  end
end