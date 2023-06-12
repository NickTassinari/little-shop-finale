require "httparty"
require "json"
require_relative "../services/holiday_service.rb"

class Holiday 
  attr_reader :date,
              :name 
  def initialize(holiday_data)
    @date = holiday_data[:date]
    @name = holiday_data[:localName]
  end
end