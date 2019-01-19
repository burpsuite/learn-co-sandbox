require 'base64'
require 'json'
require 'digest'

## Configure
class Configure
  def initialize(name = nil)
    @match = /.*?kext: .*?\\.*?([\w.\-]+) \(v.(.*?)\)\n?/
    helper().exist(name).handle(name)
  end

  def set_item(ext = nil, ver = nil)
    @array = [] unless defined?(@array)
    item = @array[@array.length] = {}
    @hash = Digest::MD5.hexdigest(ext)
    item['extension'] = ext
    item['version'] = ver
    item['checksum'] = @hash
    item['timestamp'] = Time.new.to_i
  end

  def write
    File.open('generate.json', 'w+') do |file|
      file.write(JSON.pretty_generate(@array))
    end
  end

  def exist(name = nil)
    if name.is_a?(String) && File.exist?(name)
      self
    else
      abort('File not found.')
    end
  end

  def build
    <<-BUILD
    Clover Pretty (v0.1) (built: 2018-10-31T17:43:57+00:00)
    Copyright (c) 2017-2018 Eval
    BUILD
  end

  def message
    <<-MESSAGE
    Usage: ruby Hackin.rb [Bootlog File]
    MESSAGE
  end

  def helper
    case ARGV[0]
    when '-h', '--help'
      abort(message)
    when '-v', '--version'
      abort(build)
    else
      self
    end
  end

  def handle(name = nil)
    File.open(name, 'r+').each_line do |line|
      if line =~ @match
        e, v = line.gsub(@match, '\1,\2').split(/,/)
        set_item(e, v)
      end
    end
  end

  def result
    JSON.pretty_generate(@array)
  end
end
