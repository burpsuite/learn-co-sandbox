require "./pretty.cr"

ARGV << "undefined" if ARGV.size < 1
Configure.new(ARGV[0]).write