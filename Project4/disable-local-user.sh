#!/bin/bash

usage() {
    echo "Usage: ${0} [-dra] USER [USERN]" >&2
    echo "Disable a local Linux account."
    echo " -d   Deletes accounts instead of disabling them"
    echo " -r   Removes the home directory associated with the account(s)"
    echo " -a   Creates an archive of the home directory associated with the accounts(s)"
    exit 1
}


# Run as root
if [[ "${UID}" -ne 0 ]]
then
    echo "Please run as root or sudo" >&2
    exit 1
fi

# Check if a User exists
while getopts dra: OPTION
do 
    case ${OPTION} in
        d) 
          DELETE="true"
          ;;
        r) 
          REMOVE_HOME="true"
          ;;
        a)
          ARCHIVE="true"
          ;;
        ?)
          usage
          ;;
    esac    
done


# Remove the options while leaving the remaining arguments
shift "$(( OPTIND - 1 ))"


# Check UID
UID_NUM=$(id -u ${1})

if [[ "${UID_NUM}" -lt 1000 ]]
then
    echo "That account can't be disabled"
    exit 1
else
    chage -E 0 ${1}
    echo "${1} account was disabled"
fi

# Disable accounts
echo "${#}"



# Check to see if the archive directory exists
DIR="/archives"

if [[ -d "${DIR}" ]]
then
    echo "${DIR} directory exists"
else 
    echo "${DIR} directory not found"
    exit 1
fi


