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

exchange.publish("anda tampan 1",:routing_key => "tampan_queue");
exchange.publish("anda jelek 1",:routing_key => "jelek_queue");
exchange.publish("anda malas 1",:routing_key => "malas_queue");
exchange.publish("anda tampan 2",:routing_key => "tampan_queue");
exchange.publish("anda jelek 2",:routing_key => "jelek_queue");
exchange.publish("anda malas 2",:routing_key => "malas_queue");
exchange.publish("anda tampan 3",:routing_key => "tampan_queue");
exchange.publish("anda jelek 3",:routing_key => "jelek_queue");
exchange.publish("anda malas 3",:routing_key => "malas_queue");

sleep 1.0;

conn.close;