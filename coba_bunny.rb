require 'connection_pool'
require 'bunny'

conn = Bunny.new;
conn.start;

ch = conn.create_channel;

queue1 = ch.queue("tampan_queue",:auto_delete => true);
queue2 = ch.queue("jelek_queue",:auto_delete => true);
queue3 = ch.queue("malas_queue",:auto_delete => true);

exchange = ch.default_exchange;

queue1.subscribe do |info, metadata, payload|
	puts "tampan_queue menerima #{payload}";
end;

queue2.subscribe do |info, metadata, payload|
	puts "jelek_queue menerima #{payload}";
end;

queue3.subscribe do |info, metadata, payload|
	puts "malas_queue menerima #{payload}";
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