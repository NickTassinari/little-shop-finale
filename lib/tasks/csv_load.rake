require 'csv'

namespace :csv_load do 
  desc "load customers from csv file"
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach("db/data/customers.csv", headers: true, header_converters: :symbol) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "Customer loaded successfully"
  end

  desc "load merchants from csv file"
  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach("db/data/merchants.csv", headers: true, header_converters: :symbol) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    puts "Merchant loaded successfully"
  end

  desc "load items from csv file"
  task items: :environment do
    Item.destroy_all
    CSV.foreach("db/data/items.csv", headers: true, header_converters: :symbol) do |row|
      Item.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    puts "Items loaded successfully"
  end
  
  desc "load invoices from csv file"
  task invoices: :environment do
    Invoice.destroy_all
    CSV.foreach("db/data/invoices.csv", headers: true, header_converters: :symbol) do |row|
      Invoice.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    puts "Invoices loaded successfully"
  end

  desc "load transactions from csv file"
  task transactions: :environment do
    Transaction.destroy_all
    CSV.foreach("db/data/transactions.csv", headers: true, header_converters: :symbol) do |row|
      Transaction.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    puts "Transactions loaded successfully"
  end

  desc "load invoice_items from csv file"
  task invoice_items: :environment do
    InvoiceItem.destroy_all
    CSV.foreach("db/data/invoice_items.csv", headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    puts "Invoice Items loaded successfully"
  end

  desc "Load all CSV data"
  task all: ["csv_load:customers", "csv_load:merchants", "csv_load:items", "csv_load:invoices", "csv_load:transactions", "csv_load:invoice_items"] do
    puts "All CSV data loaded"
  end
end