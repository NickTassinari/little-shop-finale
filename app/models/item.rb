class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  enum status: {"pending": 0, "disabled": 1, "enabled": 2}

  def self.enabled_items
    where("status = 2")
  end
  
  def self.disabled_items
    where("status = 1")
  end

  def self.top_five_items
    joins(invoices: [:transactions, :invoice_items])
    .where(transactions: { result: "success" })
    .group(:id)
    .select('items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
    .order('total_revenue DESC')
    .limit(5)
    # Item.joins(transactions: [:invoice_items, :invoices])
    #     .where("transactions.result = ?", "success")
    #     .select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
    #     .group("items.id")
    #     .order("total_revenue")
    #     .limit(5)
    # joins(invoices: [:invoice_items, :transactions])
    #   .where(transactions: { result: "success" })
    #   .group(:id)
    #   .select('items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
    #   .order('total_revenue DESC')
    #   .limit(5)
  end

  def num_sold(invoice)
    invoice_items.where(invoice_id: invoice.id).pluck(:quantity).first
  end

  def price_sold(invoice)
    invoice_items.where(invoice_id: invoice.id).pluck(:unit_price).first
  end

  def invoice_status(invoice)
    invoice_items.where(invoice_id: invoice.id).pluck(:status).first
  end
end