require 'open-uri'
require 'uri'
require 'json'
require 'ostruct'
require 'twitter'

HOST = "api.openweathermap.org"
PATH = "/data/2.5/weather"

COLD_TEMP = 2
SINU = "寒くて死ぬ"

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

def is_cold?(obj)
  obj.main.temp <= COLD_TEMP
end

def fetch(city)
  res = build_url(city, ENV["APP_ID"]).read
  JSON.parse(res, object_class: OpenStruct)
end

def try_post(city)
  obj = fetch(city)
  client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token = ENV['TWITTER_ACCESS_TOKEN']
    config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  end
  if is_cold?(obj)
    client.update(SINU)
  end
end

try_post("Tokyo")
