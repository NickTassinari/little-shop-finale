class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id
  belongs_to :customer
  belongs_to :coupon, optional: true 
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

  def grand_total
    return 0 if coupon && (total_revenue - coupon&.discount) < 0
    if coupon == nil 
      total_revenue 
    elsif coupon.discount_type == "dollar"
      total_revenue - coupon.discount
    else  
      total_revenue * (1 - coupon.discount / 100.00)
    end
  end
end