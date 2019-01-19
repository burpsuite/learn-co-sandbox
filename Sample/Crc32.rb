require 'zlib'

i=0; loop do
    i+=1; i > 9999 ? break : false
    if !['1', '2', '3', '4', '5','6', '7', '8', '9', '0'].include?(Zlib::crc32(i.to_s).to_s(16)[0].to_s)
        b = nil; i < 10 ? b = '   ' : i < 100 ? b = '  ' : i < 1000 ? b = ' ' : false
        puts "#{b}#{i} => " + Zlib::crc32(i.to_s).to_s(16)
    end
end