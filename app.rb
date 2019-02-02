require 'net/http'
require 'uri'

HOST = "api.openweathermap.org"
PATH = "/data/2.5/weather"

def build_url(city, id)
  URI::HTTPS.build(
      {
          :host => HOST,
          :path => PATH,
          :query => URI.encode_www_form(
              {
                  q: city,
                  appid: id,
                  units: "metric"
              })
      })
end

def fetch(city)
  url = build_url(city, ENV["APP_ID"])
  req = Net::HTTP::Get.new(url.to_s)
  res = Net::HTTP.start(url.host, url.port) do |http|
    http.request(req)
  end
end
