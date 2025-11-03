#!/bin/sh
# postremove script for som-agent
# Wazuh, Inc 2015

if getent passwd som > /dev/null 2>&1; then
  userdel som
fi

if getent group som > /dev/null 2>&1; then
  groupdel som
fi
