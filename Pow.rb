#! /usr/bin/ruby

require 'digest'

c = ARGV[0]
n = 0
hash = nil

loop do
	hash = Digest::SHA256.hexdigest(c+n.to_s)
	break if hash.start_with?('0000')
	n = n + 1;
end

puts('El nonce que resuelve la prueba de trabajo es: ' + n.to_s)
puts('Y el hash: ' + hash.to_s)