class AddCouponIDtoInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :coupon_id, :integer, null:true 
  end
end
