require 'connection_pool'
require 'bunny'

conn = Bunny.new;
conn.start;

ch = conn.create_channel;
exchange = ch.fanout("huhuhaha");

queue1 = ch.queue("tampan_queue",:auto_delete => true);
queue1.bind(exchange);
queue1.subscribe do |info,metadata,payload|
	puts "#{payload} => tampan_queue";
end;
queue2 = ch.queue("jelek_queue",:auto_delete => true);
queue2.bind(exchange);
queue2.subscribe do |info,metadata,payload|
	puts "#{payload} => jelek_queue";
end;
queue3 = ch.queue("malas_queue",:auto_delete => true);
queue3.bind(exchange);
queue3.subscribe do |info,metadata,payload|
	puts "#{payload} => malas_queue";
end;



exchange.publish("anda tampan, jelek, malas 1");
exchange.publish("anda tampan, jelek, malas 2");
exchange.publish("anda tampan, jelek, malas 3");

sleep 1.0;

conn.close;
