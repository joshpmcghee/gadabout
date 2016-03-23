require 'gadabout'

g = Gadabout::Client.new()

id = g.nodes.first["ID"]

puts g.drain(id, true)
sleep 5
puts g.drain(id, false)
