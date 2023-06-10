class AddDefaultToStatusInCoupons < ActiveRecord::Migration[7.0]
  def change
    change_column_default :coupons, :status, from: nil, to: "active"
  end
end
