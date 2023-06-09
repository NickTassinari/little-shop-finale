# require "httparty"

# class PhotoService
#   def get_url(url)
#     response = HTTParty.get(url)
#     JSON.parse(response.body, symbolize_names: true)
#   end

#   def app_logo
#     get_url("https://api.unsplash.com/photos//F6-U5fGAOik?client_id=6SX7DlgJ3uSMD5XDrORimm2vJz8gbGanlfMtQu1PXmM")
#   end

#   def item(name)
#     get_url("https://api.unsplash.com/photos/random/?client_id=6SX7DlgJ3uSMD5XDrORimm2vJz8gbGanlfMtQu1PXmM&query=#{name}")
#   end

#   def merchant_random
#     get_url("https://api.unsplash.com/photos/random?query=merchant&client_id=6SX7DlgJ3uSMD5XDrORimm2vJz8gbGanlfMtQu1PXmM")
#   end
# end