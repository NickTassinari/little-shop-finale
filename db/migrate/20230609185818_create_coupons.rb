class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :discount_type
      t.integer :discount
      t.string :coupon_code
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
