require 'open-uri'
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
  res = build_url(city, ENV["APP_ID"]).read
end
