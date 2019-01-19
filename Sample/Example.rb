require 'zlib'
require 'base64'
require 'json'
require 'securerandom'

def array
  bcc = Hash.new
  %w(apple design california).each_with_index do |item, key|
    bcc[Zlib::crc32(key.to_s, nil).to_s(16)] = Base64::encode64(item)
  end
  bcc
end

puts array.key?('f4dbdf21') ? array['f4dbdf21'] : false

