#!/bin/sh
# preremove script for som-agent
# Som, Inc 2015

control_binary="som-control"

if [ ! -f /var/ossec/bin/${control_binary} ]; then
  control_binary="ossec-control"
fi

/var/ossec/bin/${control_binary} stop
