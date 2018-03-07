require 'connection_pool'
require 'bunny'

conn = Bunny.new;
conn.start;

ch = conn.create_channel;

exchange = ch.direct("tingkat_ketampanan",:auto_delete => true);

queue = ch.queue("",:exclusive => true);
queue.bind(exchange, :routing_key => "tampan_queue");
queue.subscribe do |info,metadata,payload|
	puts "#{payload} => tampan_queue";
end;
#queue2 = ch.queue("",:exclusive => true);
queue.bind(exchange, :routing_key => "jelek_queue");
queue.subscribe do |info,metadata,payload|
	puts "#{payload} => jelek_queue";
end;
#queue3 = ch.queue("",:exclusive => true);
queue.bind(exchange, :routing_key => "malas_queue");
queue.subscribe do |info,metadata,payload|
	puts "#{payload} => malas_queue";
end;

sleep 20.0;

conn.close;