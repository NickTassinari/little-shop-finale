class Photo
  attr_reader :data,
              :description,
              :small_url,
              :full_url,
              :likes,
              :width,
              :height
              
  def initialize(data)
    @data = data
    @description = data[:description]
    @small_url = data[:urls][:small]
    @full_url = data[:urls][:full]
    @likes = data[:likes]
    @width = data[:width]
    @height = data[:height]
  end
end