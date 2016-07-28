#probe healthcheck {
#  .request =
#    "GET / HTTP/1.1"
#    "Host: localhost"
#    "Connection: close";
#  .interval = 5s;
#  .timeout = 15s;
#  .window = 5;
#  .threshold = 1;
#  #.expected_response = 200;
#}

backend web1 {
  .host = "localhost";
  .port = "8080";
  .connect_timeout = 600s;
  .first_byte_timeout = 600s;
  .between_bytes_timeout = 600s;
#  .probe = healthcheck;
}

#backend web2 {
#  .host = "web2.servers.domain.com";
#  .port = "80";
#  .connect_timeout = 600s;
#  .first_byte_timeout = 600s;
#  .between_bytes_timeout = 600s;
#  .probe = healthcheck;
#}

director default round-robin {
  {
    .backend = web1;
  }
#  {
#    .backend = web2;
#  }
}
