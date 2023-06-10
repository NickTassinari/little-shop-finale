class Coupon < ApplicationRecord
  validates_presence_of :name,
                        :discount_type,
                        :discount,
                        :coupon_code,
                        :status

  validates :discount, numericality: { only_integer: true }
  validates_uniqueness_of :coupon_code 
  belongs_to :merchant 
  has_many :invoices 


  def display_discount
    if discount_type == "dollars"
      "$#{discount}"
    else
      "#{discount}%"
    end
  end

  def times_used
    self.invoices.joins(:transactions)
                  .where(transactions: {result: "success"}, invoices: {coupon_id: self.id}).uniq.count
  end

  def invoices_in_progress
    invoices.select("invoices.*")
            .where(status: 0)
  end
end