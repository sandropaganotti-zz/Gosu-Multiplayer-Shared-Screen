require 'rubygems'
require 'socket'

t = TCPSocket.new("127.0.0.1",8888)
interrupted = false

signal_handler = proc{ 
  interrupted = true
  'IGNORE'
}

trap('INT'  ,signal_handler)
trap('TERM' ,signal_handler)

t.write("#{$*}|welcome\n")

while !interrupted do
  next if (t.readline rescue '').chomp != 'next' 
  t.write("#{$*}|#{rand() >= 0.5 ? 'left' : 'right'}\n")
end

t.write("#{$*}|close\n")
t.close