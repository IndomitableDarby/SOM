#!/usr/bin/env bash

if [ $1 == "standalone" ]; then
  # Remove workers upstream configurations (in upstream mycluster and upstream register)
  sed -i -E '/som-worker1|som-worker2/d' /etc/haproxy/haproxy.conf;
fi

haproxy -f /etc/haproxy/haproxy.conf
tail -f /dev/null
