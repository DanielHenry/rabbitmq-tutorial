require 'connection_pool'
require 'bunny'

conn = Bunny.new;
conn.start;

ch = conn.create_channel;

exchange = ch.direct("tingkat_ketampanan",:auto_delete => true);

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