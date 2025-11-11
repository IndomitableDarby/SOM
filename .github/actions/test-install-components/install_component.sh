#!/bin/bash
package_name=$1
target=$2

# Check parameters
if [ -z "$package_name" ] || [ -z "$target" ]; then
    echo "Error: Both package_name and target must be provided."
    echo "Usage: $0 <package_name> <target>"
    exit 1
fi

echo "Installing Som $target."

if [ -n "$(command -v yum)" ]; then
    install="yum install -y --nogpgcheck"
    installed_log="/var/log/yum.log"
elif [ -n "$(command -v dpkg)" ]; then
    install="dpkg --install"
    installed_log="/var/log/dpkg.log"
else
    common_logger -e "Couldn't find type of system"
    exit 1
fi

if [ "${ARCH}" = "i386" ] || [ "${ARCH}" = "armhf" ]; then
    linux="linux32"
    if [ "${ARCH}" = "armhf" ] && [ "${SYSTEM}" = "rpm" ]; then
        install="rpm -ivh --force --ignorearch"
        SOM_MANAGER="10.0.0.2" $linux $install "/packages/$package_name"| tee /packages/status.log
        if [ "$(rpm -qa | grep som-agent)" ]; then
            echo " installed som-agent" >> /packages/status.log
            exit 0
        else
            echo "Package could not be installed."
            exit 1
        fi
    fi
fi

SOM_MANAGER="10.0.0.2" $linux $install "/packages/$package_name"| tee /packages/status.log
grep -i " installed.*som-$target" $installed_log| tee -a /packages/status.log

# Retrieve som gid and uid
som_gid=$(getent group som | cut -d: -f3)
som_uid=$(getent passwd som | cut -d: -f3)

echo $som_gid > /tests/som_gid
echo $som_uid > /tests/som_uid
