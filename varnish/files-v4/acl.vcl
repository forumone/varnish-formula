vcl 4.0;
acl purge {
  "localhost";
  "127.0.0.1"/24;
  "::1"/24;
}

acl internal {
  "localhost";
  "127.0.0.1"/24;
  "::1"/24;
}
