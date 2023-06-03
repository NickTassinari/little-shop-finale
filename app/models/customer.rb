class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items

  def self.top_five_by_successful_transactions
    Customer.select("customers.*, count(transactions.id)")
      .joins(:transactions)
      .where("transactions.result": "success")
      .group(:id)
      .order(count: :desc)
      .limit(5)
  end

  def num_successful_transactions
    transactions.where(result: "success").count
  end
  
end