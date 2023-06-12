# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

InvoiceItem.destroy_all
Invoice.destroy_all
Item.destroy_all
Transaction.destroy_all
Merchant.destroy_all
Customer.destroy_all

system("rails csv_load:all")

@merchant = Merchant.create!(name: "Ricky's Used Crap")
@coupon_1 = Coupon.create!(name: "BOGO 25% OFF", discount_type: "percentage", discount: 25, coupon_code: "Juneteenthbogo", merchant_id: @merchant.id, status: "active")
@coupon_2 = Coupon.create!(name: "BOGO 40% OFF", discount_type: "percentage", discount: 40, coupon_code: "Independencebogo", merchant_id: @merchant.id, status: "active")
@coupon_3 = Coupon.create!(name: "BOGO 50% OFF", discount_type: "percentage", discount: 50, coupon_code: "Laborbogo", merchant_id: @merchant.id, status: "active")
@coupon_4 = Coupon.create!(name: "Twenty whole dollars OFF", discount_type: "dollars", discount: 20, coupon_code: "twentybills", merchant_id: @merchant.id, status: "active")

@item_1 = Item.create!(name: "Pepperoni", description: "Spicy boi", merchant: @merchant, unit_price: 2000)
@item_2 = Item.create!(name: "Smokes Let's Go", description: "smokey", merchant: @merchant, unit_price: 3400)
@item_3 = Item.create!(name: "Zesty Mordant and Dressed All Over", description: "Chips", merchant: @merchant, unit_price: 600)

@custie_1 = Customer.create!(first_name: "Terry", last_name: "Tromboli")

@invoice_1 = Invoice.create!(customer_id: @custie_1.id, status: 0, coupon_id: @coupon_1.id)
@invoice_2 = Invoice.create!(customer_id: @custie_1.id, status: 1, coupon_id: @coupon_3.id)
@invoice_item_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, unit_price: 20, quantity: 10, status: 1)
@invoice_item_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, unit_price: 34, quantity: 10, status: 1)
@invoice_item_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_3.id, unit_price: 6, quantity: 10, status: 1)
@invoice_item_4 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, unit_price: 10, quantity: 10, status: 1)
