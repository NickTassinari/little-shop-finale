class HolidaySearch

  def service
    NagerHolidayService.three_holidays
  end

  def holiday_information
    service.map do |holiday|
      Holiday.new(holiday)
    end 
  end
end