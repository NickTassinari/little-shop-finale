# require "./app/services/photo_service.rb"
# require "json"
# require "./app/poros/photo.rb"
# require "httparty"

# class PhotoBuilder
#   def self.service
#     PhotoService.new
#   end

#   def self.app_logo
#     Photo.new(service.app_logo)
#   end

#   def self.item_photo(name)
#     Photo.new(service.item(name))
#   end

#   def self.merchant_random
#     Photo.new(service.merchant_random)
#   end
# end