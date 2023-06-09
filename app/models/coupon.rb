class Coupon < ApplicationRecord
  validates_presence_of :name,
                        :discount_type,
                        :discount,
                        :coupon_code

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
end