#!/bin/sh
# uninstall script for som-agent
# Som, Inc 2015

control_binary="som-control"

if [ ! -f /var/ossec/bin/${control_binary} ]; then
  control_binary="ossec-control"
fi

## Stop and remove application
/var/ossec/bin/${control_binary} stop
rm -rf /var/ossec/

# remove launchdaemons
rm -f /etc/init.d/som-agent
rm -rf /etc/rc2.d/S97som-agent
rm -rf /etc/rc3.d/S97som-agent

## Remove User and Groups
userdel som 2> /dev/null
groupdel som 2> /dev/null

exit 0
