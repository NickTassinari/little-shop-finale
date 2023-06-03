class AdminController < ApplicationController
  def index
    @customers = Customer.top_five_by_successful_transactions
    @invoices = Invoice.all
  end
end