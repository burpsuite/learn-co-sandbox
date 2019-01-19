require 'net/http'
require 'json'

uri = URI('http://httpbin.org/get')
params = { :limit => 10, :page => 3 }
uri.query = URI.encode_www_form(params)

res = Net::HTTP.get_response(uri)

puts res.to_hash
# puts res.body if res.is_a?(Net::HTTPSuccess)