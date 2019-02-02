require 'open-uri'
require 'uri'
require 'json'
require 'ostruct'

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
  JSON.parse(res, object_class: OpenStruct)
end
