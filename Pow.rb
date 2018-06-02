#! /usr/bin/ruby

require 'digest'
require 'scrypt' # Necesita 'gem install scrypt'
require 'benchmark'

scryptFlag = ARGV[1]

c = ARGV[0]
n = 0
hash = nil

executionTime = Benchmark.realtime {
	if scryptFlag == 's'
		SCrypt::Engine.calibrate!(max_time: 0.001) # Configura el coste del cálculo
		loop do
			hash = SCrypt::Password.create(c+n.to_s).digest
			break if hash.start_with?('0000')
			n = n + 1;
		end
	else 
		loop do
			hash = Digest::SHA256.hexdigest(c+n.to_s)
			break if hash.start_with?('0000')
			n = n + 1;
		end
	end
}

puts('Completado en ' + executionTime.round(3).to_s + ' segundos!')
puts('El nonce que resuelve la prueba de trabajo es: ' + n.to_s)
puts('Hash: ' + hash.to_s)
puts('Se han generado ' + (n/executionTime).round.to_s + ' hashes por segundo.')