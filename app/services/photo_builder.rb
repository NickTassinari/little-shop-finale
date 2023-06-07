class PhotoBuilder
  def self.app_logo
    logo = self.service.app_logo
    Photo.new(logo)
  end

  def self.service
    PhotoService.new
  end
end