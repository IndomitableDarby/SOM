#!/bin/sh

## Stop and remove application
sudo /Library/Ossec/bin/som-control stop
sudo /bin/rm -r /Library/Ossec*

# remove launchdaemons
/bin/rm -f /Library/LaunchDaemons/com.som.agent.plist

## remove StartupItems
/bin/rm -rf /Library/StartupItems/SOM

## Remove User and Groups
/usr/bin/dscl . -delete "/Users/som"
/usr/bin/dscl . -delete "/Groups/som"

/usr/sbin/pkgutil --forget com.som.pkg.som-agent
/usr/sbin/pkgutil --forget com.som.pkg.som-agent-etc

# In case it was installed via Puppet pkgdmg provider

if [ -e /var/db/.puppet_pkgdmg_installed_som-agent ]; then
    rm -f /var/db/.puppet_pkgdmg_installed_som-agent
fi

echo
echo "Som agent correctly removed from the system."
echo

exit 0
