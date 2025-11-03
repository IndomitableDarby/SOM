#! /bin/bash
# By Spransy, Derek" <DSPRANS () emory ! edu> and Charlie Scott
# Modified by Som, Inc. <info@som.com>.
# This program is a free software; you can redistribute it and/or modify it under the terms of GPLv2

#####
# This checks for an error and exits with a custom message
# Returns zero on success
# $1 is the message
# $2 is the error code

DIR="/Library/Ossec"
ARCH="PACKAGE_ARCH"

function check_errm
{
    if  [[ ${?} != "0" ]]
        then
        echo "${1}";
        exit ${2};
        fi
}

function check_arch
{
    local system_arch=$(uname -m)

    if [ "$ARCH" = "intel64" ] && [ "$system_arch" = "arm64" ]; then
        if ! arch -x86_64 zsh -c '' &> /dev/null; then
            >&2 echo "ERROR: Rosetta is not installed. Please install it and try again."
            exit 1
        fi
    elif [ "$ARCH" = "arm64" ] && [ "$system_arch" = "x86_64" ]; then
        >&2 echo "ERROR: Incompatible architecture. Please use the Intel package on this system."
        exit 1
    fi
}

check_arch

if [ -d "${DIR}" ]; then
    echo "A Som agent installation was found in ${DIR}. Will perform an upgrade."
    upgrade="true"
    touch "${DIR}/SOM_PKG_UPGRADE"

    if [ -f "${DIR}/SOM_RESTART" ]; then
        rm -f "${DIR}/SOM_RESTART"
    fi

    # Stops the agent before upgrading it
    if ${DIR}/bin/som-control status | grep "is running" > /dev/null 2>&1; then
        touch "${DIR}/SOM_RESTART"
        ${DIR}/bin/som-control stop
        restart="true"
    elif ${DIR}/bin/ossec-control status | grep "is running" > /dev/null 2>&1; then
        touch "${DIR}/SOM_RESTART"
        ${DIR}/bin/ossec-control stop
        restart="true"
    fi

    echo "Backing up configuration files to ${DIR}/config_files/"
    mkdir -p ${DIR}/config_files/
    cp -r ${DIR}/etc/{ossec.conf,client.keys,local_internal_options.conf,shared} ${DIR}/config_files/

    if [ -d ${DIR}/logs/ossec ]; then
        echo "Renaming ${DIR}/logs/ossec to ${DIR}/logs/som"
        mv ${DIR}/logs/ossec ${DIR}/logs/som
    fi

    if [ -d ${DIR}/queue/ossec ]; then
        echo "Renaming ${DIR}/queue/ossec to ${DIR}/queue/sockets"
        mv ${DIR}/queue/ossec ${DIR}/queue/sockets
    fi

    if pkgutil --pkgs | grep -i som-agent-etc > /dev/null 2>&1 ; then
        echo "Removing previous package receipt for som-agent-etc"
        pkgutil --forget com.som.pkg.som-agent-etc
    fi
fi

DSCL="/usr/bin/dscl";
if [[ ! -f "$DSCL" ]]
    then
    echo "Error: I couldn't find dscl, dying here";
    exit
fi


# get unique id numbers (uid, gid) that are greater than 100
echo "Getting unique id numbers (uid, gid)"
unset -v i new_uid new_gid idvar;
declare -i new_uid=0 new_gid=0 i=100 idvar=0;
while [[ $idvar -eq 0 ]]; do
    i=$[i+1]
    if [[ -z "$(${DSCL} . -search /Users uid ${i})" ]] && [[ -z "$(${DSCL} . -search /Groups gid ${i})" ]];
        then
        echo "Found available UID and GID: $i"
        new_uid=$i
        new_gid=$i
        idvar=1
   fi
done

echo "UID available for som user is:";
echo ${new_uid}

# Verify that the uid and gid exist and match
if [[ $new_uid -eq 0 ]] || [[ $new_gid -eq 0 ]];
    then
    echo "Getting unique id numbers (uid, gid) failed!";
    exit 1;
fi
if [[ ${new_uid} != ${new_gid} ]]
    then
    echo "I failed to find matching free uid and gid!";
    exit 5;
fi

# Creating the group
echo "Checking group..."
if [[ $(dscl . -read /Groups/som) ]]
    then
    echo "som group already exists.";
else
    sudo ${DSCL} localhost -create /Local/Default/Groups/som
    check_errm "Error creating group som" "67"
    sudo ${DSCL} localhost -createprop /Local/Default/Groups/som PrimaryGroupID ${new_gid}
    sudo ${DSCL} localhost -createprop /Local/Default/Groups/som RealName som
    sudo ${DSCL} localhost -createprop /Local/Default/Groups/som RecordName som
    sudo ${DSCL} localhost -createprop /Local/Default/Groups/som RecordType: dsRecTypeStandard:Groups
    sudo ${DSCL} localhost -createprop /Local/Default/Groups/som Password "*"
fi

# Creating the user
echo "Checking user..."
if [[ $(dscl . -read /Users/som) ]]
    then
    echo "som user already exists.";
else
    sudo ${DSCL} localhost -create /Local/Default/Users/som
    check_errm "Error creating user som" "77"
    sudo ${DSCL} localhost -createprop /Local/Default/Users/som RecordName som
    sudo ${DSCL} localhost -createprop /Local/Default/Users/som RealName som
    sudo ${DSCL} localhost -createprop /Local/Default/Users/som UserShell /usr/bin/false
    sudo ${DSCL} localhost -createprop /Local/Default/Users/som NFSHomeDirectory /var/som
    sudo ${DSCL} localhost -createprop /Local/Default/Users/som UniqueID ${new_uid}
    sudo ${DSCL} localhost -createprop /Local/Default/Users/som PrimaryGroupID ${new_gid}
    sudo ${DSCL} localhost -append /Local/Default/Groups/som GroupMembership som
    sudo ${DSCL} localhost -createprop /Local/Default/Users/som Password "*"
fi

#Hide the fixed users
echo "Hiding the fixed som user"
dscl . create /Users/som IsHidden 1
