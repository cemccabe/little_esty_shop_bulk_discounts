require 'httparty'
require 'json'

class HolidayService
  def self.get_holiday_data
    response = HTTParty.get("https://date.nager.at/api/v3/NextPublicHolidays/us")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def self.holiday_name
    get_holiday_data[0..2].map do |holiday|
      holiday[:name]
    end
  end

  def self.holiday_date
    get_holiday_data[0..2].map do |holiday|
      holiday[:date]
    end
  end
end