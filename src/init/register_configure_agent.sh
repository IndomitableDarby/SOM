#!/bin/bash

# Copyright (C) 2015, Som Inc.
#
# This program is free software; you can redistribute it
# and/or modify it under the terms of the GNU General Public
# License (version 2) as published by the FSF - Free Software
# Foundation.

# Global variables
INSTALLDIR=${1}
CONF_FILE="${INSTALLDIR}/etc/ossec.conf"
TMP_ENROLLMENT="${INSTALLDIR}/tmp/enrollment-configuration"
TMP_SERVER="${INSTALLDIR}/tmp/server-configuration"
SOM_REGISTRATION_PASSWORD_PATH="etc/authd.pass"
SOM_MACOS_AGENT_DEPLOYMENT_VARS="/tmp/som_envs"


# Set default sed alias
sed="sed -ri"
# By default, use gnu sed (gsed).
use_unix_sed="False"

# Special function to use generic sed
unix_sed() {

    sed_expression="$1"
    target_file="$2"
    special_args="$3"

    sed ${special_args} "${sed_expression}" "${target_file}" > "${target_file}.tmp"
    cat "${target_file}.tmp" > "${target_file}"
    rm "${target_file}.tmp"

}

# Update the value of a XML tag inside the ossec.conf
edit_value_tag() {

    file=""

    if [ -z "$3" ]; then
        file="${CONF_FILE}"
    else
        file="${TMP_ENROLLMENT}"
    fi

    if [ -n "$1" ] && [ -n "$2" ]; then
        start_config="$(grep -n "<$1>" "${file}" | cut -d':' -f 1)"
        end_config="$(grep -n "</$1>" "${file}" | cut -d':' -f 1)"
        if [ -z "${start_config}" ] && [ -z "${end_config}" ] && [ "${file}" = "${TMP_ENROLLMENT}" ]; then
            echo "      <$1>$2</$1>" >> "${file}"
        elif [ "${use_unix_sed}" = "False" ] ; then
            ${sed} "s#<$1>.*</$1>#<$1>$2</$1>#g" "${file}"
        else
            unix_sed "s#<$1>.*</$1>#<$1>$2</$1>#g" "${file}"
        fi
    fi
    
    if [ "$?" != "0" ]; then
        echo "$(date '+%Y/%m/%d %H:%M:%S') agent-auth: Error updating $2 with variable $1." >> "${INSTALLDIR}/logs/ossec.log"
    fi

}

delete_blank_lines() {

    file=$1
    if [ "${use_unix_sed}" = "False" ] ; then
        ${sed} '/^$/d' "${file}"
    else
        unix_sed '/^$/d' "${file}"
    fi

}

delete_auto_enrollment_tag() {

    # Delete the configuration tag if its value is empty
    # This will allow using the default value
    if [ "${use_unix_sed}" = "False" ] ; then
        ${sed} "s#.*<$1>.*</$1>.*##g" "${TMP_ENROLLMENT}"
    else
        unix_sed "s#.*<$1>.*</$1>.*##g" "${TMP_ENROLLMENT}"
    fi

    cat -s "${TMP_ENROLLMENT}" > "${TMP_ENROLLMENT}.tmp"
    mv "${TMP_ENROLLMENT}.tmp" "${TMP_ENROLLMENT}"

}

# Change address block of the ossec.conf
add_adress_block() {

    # Remove the server configuration
    if [ "${use_unix_sed}" = "False" ] ; then
        ${sed} "/<server>/,/\/server>/d" "${CONF_FILE}"
    else
        unix_sed "/<server>/,/\/server>/d" "${CONF_FILE}"
    fi

    # Write the client configuration block
    for i in "${!ADDRESSES[@]}";
    do
        {
            echo "    <server>"
            echo "      <address>${ADDRESSES[i]}</address>"
            echo "      <port>1514</port>"
            if [ -n "${PROTOCOLS[i]}" ]; then
                echo "      <protocol>${PROTOCOLS[i]}</protocol>"
            else
                echo "      <protocol>tcp</protocol>"
            fi 
            echo "    </server>"
        } >> "${TMP_SERVER}"
    done

    if [ "${use_unix_sed}" = "False" ] ; then
        ${sed} "/<client>/r ${TMP_SERVER}" "${CONF_FILE}"
    else
        unix_sed "/<client>/r ${TMP_SERVER}" "${CONF_FILE}"
    fi

    rm -f "${TMP_SERVER}"

}

add_parameter () {

    if [ -n "$3" ]; then
        OPTIONS="$1 $2 $3"
    fi
    echo "${OPTIONS}"

}

get_deprecated_vars () {

    if [ -n "${SOM_MANAGER_IP}" ] && [ -z "${SOM_MANAGER}" ]; then
        SOM_MANAGER=${SOM_MANAGER_IP}
    fi
    if [ -n "${SOM_AUTHD_SERVER}" ] && [ -z "${SOM_REGISTRATION_SERVER}" ]; then
        SOM_REGISTRATION_SERVER=${SOM_AUTHD_SERVER}
    fi
    if [ -n "${SOM_AUTHD_PORT}" ] && [ -z "${SOM_REGISTRATION_PORT}" ]; then
        SOM_REGISTRATION_PORT=${SOM_AUTHD_PORT}
    fi
    if [ -n "${SOM_PASSWORD}" ] && [ -z "${SOM_REGISTRATION_PASSWORD}" ]; then
        SOM_REGISTRATION_PASSWORD=${SOM_PASSWORD}
    fi
    if [ -n "${SOM_NOTIFY_TIME}" ] && [ -z "${SOM_KEEP_ALIVE_INTERVAL}" ]; then
        SOM_KEEP_ALIVE_INTERVAL=${SOM_NOTIFY_TIME}
    fi
    if [ -n "${SOM_CERTIFICATE}" ] && [ -z "${SOM_REGISTRATION_CA}" ]; then
        SOM_REGISTRATION_CA=${SOM_CERTIFICATE}
    fi
    if [ -n "${SOM_PEM}" ] && [ -z "${SOM_REGISTRATION_CERTIFICATE}" ]; then
        SOM_REGISTRATION_CERTIFICATE=${SOM_PEM}
    fi
    if [ -n "${SOM_KEY}" ] && [ -z "${SOM_REGISTRATION_KEY}" ]; then
        SOM_REGISTRATION_KEY=${SOM_KEY}
    fi
    if [ -n "${SOM_GROUP}" ] && [ -z "${SOM_AGENT_GROUP}" ]; then
        SOM_AGENT_GROUP=${SOM_GROUP}
    fi

}

set_vars () {

    export SOM_MANAGER
    export SOM_MANAGER_PORT
    export SOM_PROTOCOL
    export SOM_REGISTRATION_SERVER
    export SOM_REGISTRATION_PORT
    export SOM_REGISTRATION_PASSWORD
    export SOM_KEEP_ALIVE_INTERVAL
    export SOM_TIME_RECONNECT
    export SOM_REGISTRATION_CA
    export SOM_REGISTRATION_CERTIFICATE
    export SOM_REGISTRATION_KEY
    export SOM_AGENT_NAME
    export SOM_AGENT_GROUP
    export ENROLLMENT_DELAY
    # The following variables are yet supported but all of them are deprecated
    export SOM_MANAGER_IP
    export SOM_NOTIFY_TIME
    export SOM_AUTHD_SERVER
    export SOM_AUTHD_PORT
    export SOM_PASSWORD
    export SOM_GROUP
    export SOM_CERTIFICATE
    export SOM_KEY
    export SOM_PEM

    if [ -r "${SOM_MACOS_AGENT_DEPLOYMENT_VARS}" ]; then
        . ${SOM_MACOS_AGENT_DEPLOYMENT_VARS}
        rm -rf "${SOM_MACOS_AGENT_DEPLOYMENT_VARS}"
    fi

}

unset_vars() {

    vars=(SOM_MANAGER_IP SOM_PROTOCOL SOM_MANAGER_PORT SOM_NOTIFY_TIME \
          SOM_TIME_RECONNECT SOM_AUTHD_SERVER SOM_AUTHD_PORT SOM_PASSWORD \
          SOM_AGENT_NAME SOM_GROUP SOM_CERTIFICATE SOM_KEY SOM_PEM \
          SOM_MANAGER SOM_REGISTRATION_SERVER SOM_REGISTRATION_PORT \
          SOM_REGISTRATION_PASSWORD SOM_KEEP_ALIVE_INTERVAL SOM_REGISTRATION_CA \
          SOM_REGISTRATION_CERTIFICATE SOM_REGISTRATION_KEY SOM_AGENT_GROUP \
          ENROLLMENT_DELAY)

    for var in "${vars[@]}"; do
        unset "${var}"
    done

}

# Function to convert strings to lower version
tolower () {

    echo "$1" | tr '[:upper:]' '[:lower:]'

}


# Add auto-enrollment configuration block
add_auto_enrollment () {

    start_config="$(grep -n "<enrollment>" "${CONF_FILE}" | cut -d':' -f 1)"
    end_config="$(grep -n "</enrollment>" "${CONF_FILE}" | cut -d':' -f 1)"
    if [ -n "${start_config}" ] && [ -n "${end_config}" ]; then
        start_config=$(( start_config + 1 ))
        end_config=$(( end_config - 1 ))
        sed -n "${start_config},${end_config}p" "${INSTALLDIR}/etc/ossec.conf" >> "${TMP_ENROLLMENT}"
    else
        # Write the client configuration block
        {
            echo "    <enrollment>"
            echo "      <enabled>yes</enabled>"
            echo "      <manager_address>MANAGER_IP</manager_address>"
            echo "      <port>1515</port>"
            echo "      <agent_name>agent</agent_name>"
            echo "      <groups>Group1</groups>"
            echo "      <server_ca_path>/path/to/server_ca</server_ca_path>"
            echo "      <agent_certificate_path>/path/to/agent.cert</agent_certificate_path>"
            echo "      <agent_key_path>/path/to/agent.key</agent_key_path>"
            echo "      <authorization_pass_path>/path/to/authd.pass</authorization_pass_path>"
            echo "      <delay_after_enrollment>20</delay_after_enrollment>"
            echo "    </enrollment>" 
        } >> "${TMP_ENROLLMENT}"
    fi

}

# Add the auto_enrollment block to the configuration file
concat_conf() {

    if [ "${use_unix_sed}" = "False" ] ; then
        ${sed} "/<\/crypto_method>/r ${TMP_ENROLLMENT}" "${CONF_FILE}"
    else
        unix_sed "/<\/crypto_method>/r ${TMP_ENROLLMENT}/" "${CONF_FILE}"
    fi

    rm -f "${TMP_ENROLLMENT}"

}

# Set autoenrollment configuration
set_auto_enrollment_tag_value () {

    tag="$1"
    value="$2"

    if [ -n "${value}" ]; then
        edit_value_tag "${tag}" "${value}" "auto_enrollment"
    else
        delete_auto_enrollment_tag "${tag}" "auto_enrollment"
    fi

}

# Main function the script begin here
main () {

    uname_s=$(uname -s)

    # Check what kind of system we are working with
    if [ "${uname_s}" = "Darwin" ]; then
        sed="sed -ire"
        set_vars
    elif [ "${uname_s}" = "AIX" ] || [ "${uname_s}" = "SunOS" ] || [ "${uname_s}" = "HP-UX" ]; then
        use_unix_sed="True"
    fi

    get_deprecated_vars

    if [ -z "${SOM_MANAGER}" ] && [ -n "${SOM_PROTOCOL}" ]; then
        PROTOCOLS=( $(tolower "${SOM_PROTOCOL//,/ }") )
        edit_value_tag "protocol" "${PROTOCOLS[0]}"
    fi

    if [ -n "${SOM_MANAGER}" ]; then
        if [ ! -f "${INSTALLDIR}/logs/ossec.log" ]; then
            touch -f "${INSTALLDIR}/logs/ossec.log"
            chmod 660 "${INSTALLDIR}/logs/ossec.log"
            chown root:som "${INSTALLDIR}/logs/ossec.log"
        fi

        # Check if multiples IPs are defined in variable SOM_MANAGER
        ADDRESSES=( ${SOM_MANAGER//,/ } ) 
        PROTOCOLS=( $(tolower "${SOM_PROTOCOL//,/ }") )
        # Get uniques values if all protocols are the same
        if ( [ "${#PROTOCOLS[@]}" -ge "${#ADDRESSES[@]}" ] && ( ( ! echo "${PROTOCOLS[@]}" | grep -q -w "tcp" ) || ( ! echo "${PROTOCOLS[@]}" | grep -q -w "udp" ) ) ) || [ ${#PROTOCOLS[@]} -eq 0 ] || ( ! echo "${PROTOCOLS[@]}" | grep -q -w "udp" ) ; then
            ADDRESSES=( $(echo "${ADDRESSES[@]}" |  tr ' ' '\n' | cat -n | sort -uk2 | sort -n | cut -f2- | tr '\n' ' ') ) 
        fi
        
        add_adress_block
    fi

    edit_value_tag "port" "${SOM_MANAGER_PORT}"

    if [ -n "${SOM_REGISTRATION_SERVER}" ] || [ -n "${SOM_REGISTRATION_PORT}" ] || [ -n "${SOM_REGISTRATION_CA}" ] || [ -n "${SOM_REGISTRATION_CERTIFICATE}" ] || [ -n "${SOM_REGISTRATION_KEY}" ] || [ -n "${SOM_AGENT_NAME}" ] || [ -n "${SOM_AGENT_GROUP}" ] || [ -n "${ENROLLMENT_DELAY}" ] || [ -n "${SOM_REGISTRATION_PASSWORD}" ]; then
        add_auto_enrollment
        set_auto_enrollment_tag_value "manager_address" "${SOM_REGISTRATION_SERVER}"
        set_auto_enrollment_tag_value "port" "${SOM_REGISTRATION_PORT}"
        set_auto_enrollment_tag_value "server_ca_path" "${SOM_REGISTRATION_CA}"
        set_auto_enrollment_tag_value "agent_certificate_path" "${SOM_REGISTRATION_CERTIFICATE}"
        set_auto_enrollment_tag_value "agent_key_path" "${SOM_REGISTRATION_KEY}"
        set_auto_enrollment_tag_value "authorization_pass_path" "${SOM_REGISTRATION_PASSWORD_PATH}"
        set_auto_enrollment_tag_value "agent_name" "${SOM_AGENT_NAME}"
        set_auto_enrollment_tag_value "groups" "${SOM_AGENT_GROUP}"
        set_auto_enrollment_tag_value "delay_after_enrollment" "${ENROLLMENT_DELAY}"
        delete_blank_lines "${TMP_ENROLLMENT}"
        concat_conf
    fi

            
    if [ -n "${SOM_REGISTRATION_PASSWORD}" ]; then
        echo "${SOM_REGISTRATION_PASSWORD}" > "${INSTALLDIR}/${SOM_REGISTRATION_PASSWORD_PATH}"
        chmod 640 "${INSTALLDIR}"/"${SOM_REGISTRATION_PASSWORD_PATH}"
        chown root:som "${INSTALLDIR}"/"${SOM_REGISTRATION_PASSWORD_PATH}"
    fi

    # Options to be modified in ossec.conf
    edit_value_tag "notify_time" "${SOM_KEEP_ALIVE_INTERVAL}"
    edit_value_tag "time-reconnect" "${SOM_TIME_RECONNECT}"

    unset_vars

}

# Start script execution
main "$@"
