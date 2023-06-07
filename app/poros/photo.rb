class Photo
  attr_reader :data,
              :description,
              :url,
              :likes

  def initialize(data)
    @data = data
    @description = data[:description]
    @url = data[:urls][:small]
    @likes = data[:likes]
  end
end