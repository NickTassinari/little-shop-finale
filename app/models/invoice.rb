class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: {"in progress": 0, "completed": 1, "cancelled": 2}

  def self.incomplete_invoices
    Invoice.joins(:invoice_items).where.not("invoice_items.status = 2").distinct.order(created_at: :desc)
  end

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end
end