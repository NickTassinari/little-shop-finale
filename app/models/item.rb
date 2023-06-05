class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

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