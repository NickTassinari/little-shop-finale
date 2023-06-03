# This file is copied to spec/ when you run 'rails generate rspec:install'

#   @merchant = create(:merchant)
#   @item_1 = create(:item, merchant: @merchant)
#   @customer_1 = create(:customer)
#   @invoice = create(:invoice, customer: @customer_1)
#   @transaction = create(:transaction, invoice: @invoice)
#   @invoice_item = create(:invoice_item, item: @item_1, invoice: @invoice)
def top_customer_data
  @merchant = create(:merchant)
  @item_1 = create(:item, merchant: @merchant)

  @customer_1 = create(:customer)
  @invoice_1 = create(:invoice, customer: @customer_1)
  @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)

  @customer_2 = create(:customer)
  @invoice_2 = create(:invoice, customer: @customer_2)
  @invoice_item_2 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id)
  @transaction_3 = create(:transaction, result: "success", invoice: @invoice_2)

  @customer_3 = create(:customer)
  @invoice_3 = create(:invoice, customer: @customer_3)
  @invoice_item_3 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_3.id)
  @transaction_4 = create(:transaction, result: "success", invoice: @invoice_3)
  @transaction_5 = create(:transaction, result: "success", invoice: @invoice_3)
  @transaction_6 = create(:transaction, result: "success", invoice: @invoice_3)

  @customer_4 = create(:customer)
  @invoice_4 = create(:invoice, customer: @customer_4)
  @invoice_item_4 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_4.id)
  @transaction_7 = create(:transaction, result: "success", invoice: @invoice_4)
  @transaction_8 = create(:transaction, result: "success", invoice: @invoice_4)

  @customer_5 = create(:customer)
  @invoice_5 = create(:invoice, customer: @customer_5)
  @invoice_item_5 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_5.id)
  @transaction_9 = create(:transaction, result: "success", invoice: @invoice_5)
  @transaction_10 = create(:transaction, result: "success", invoice: @invoice_5)
  @transaction_11 = create(:transaction, result: "success", invoice: @invoice_5)
  @transaction_17 = create(:transaction, result: "success", invoice: @invoice_5)

  @customer_6 = create(:customer)
  @invoice_6 = create(:invoice, customer: @customer_6)
  @invoice_item_6 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_6.id)
  @transaction_12 = create(:transaction, result: "success", invoice: @invoice_6)
  @transaction_13 = create(:transaction, result: "success", invoice: @invoice_6)
  @transaction_14 = create(:transaction, result: "success", invoice: @invoice_6)
  @transaction_15 = create(:transaction, result: "success", invoice: @invoice_6)
  @transaction_16 = create(:transaction, result: "success", invoice: @invoice_6)
end

def merch_status_data
  @merchant_1 = create(:merchant, status: 0)
  @merchant_2 = create(:merchant, status: 0)
  @merchant_3 = create(:merchant, status: 1)
  @merchant_4 = create(:merchant, status: 1)
  @merchant_5 = create(:merchant, status: 1)
end




require 'simplecov'
SimpleCov.start
require 'spec_helper'
require 'faker'
require 'factory_bot'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:

  config.include FactoryBot::Syntax::Methods
  # config.filter_gems_from_backtrace("gem name")
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
     with.test_framework :rspec
     with.library :rails
  end
end
