class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  enum status: {"disabled": 0, "enabled": 1}

  def self.enabled_merchants
    where('status = 1')
  end

  def self.disabled_merchants
    where('status = 0')
  end

  def top_five_customers
    Merchant.joins(invoice_items: [invoice: [customer: :transactions]])
            .where(merchants: { id: id }, transactions: { result: "success" })
            .select("customers.*, count(transactions.id) as transaction_count")
            .group("customers.id")
            .order(count: :desc)
            .limit(5)
  end

  def items_for_this_invoice(invoice_id)
    invoice_items.where(invoice_id: invoice_id)
  end

  def invoice_revenue(invoice_id)
    items_for_this_invoice(invoice_id).sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def self.top_5_merchants
    Merchant.joins(:transactions)
            .where('transactions.result = ?', 'success')
            .select("merchants.id, merchants.name, SUM(invoice_items.unit_price * invoice_items.quantity) as tot_revenue")
            .group("merchants.id")
            .order("tot_revenue desc")
            .limit(5)
  end
end