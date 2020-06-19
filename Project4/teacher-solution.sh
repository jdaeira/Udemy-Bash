#!/bin/bash

# This script disables, deletes, and/or archives users on the local system

DIR="/archive"

# Display the usage and exit
usage() {
    echo "Usage: ${0} [-dra] USER [USERN]" >&2
    echo "Disable a local Linux account."
    echo " -d   Deletes accounts instead of disabling them"
    echo " -r   Removes the home directory associated with the account(s)"
    echo " -a   Creates an archive of the home directory associated with the accounts(s)"
    exit 1
}

# Make sure the script is being executed with superuser privileges
if [[ "${UID}" -ne 0 ]]
then
    echo "Please run as root or sudo" >&2
    exit 1
fi

# Parse the options
while getopts dra OPTION
do 
    case ${OPTION} in
        d) 
          DELETE_USER="true"
          ;;
        r) 
          REMOVE_HOME="-r"
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


# If the user doesn't supply at least one argument, give them help
if [[ "${#}" -eq 0 ]]
then
    usage    
fi

# Loop through all the usernames supplied as arguments
for USER_NAME in ${@}
do
    # Check to see if the UID of the user is at least 1000
    echo "Processing user: ${USER_NAME}"
    UID_NUM=$(id -u ${USER_NAME})

    # Make sure the UID of the account is at least 1000
    if [[ "${UID_NUM}" -lt 1000 ]]
    then
        echo "That account can't be disabled"
        exit 1
    fi

    # Archives the Users home directory if the option is selected
    if [[ "${ARCHIVE}" = "true" ]]
    then 
        # Check to see if the archive directory exists
        if [[ -d "${DIR}" ]]
        then
            sudo tar -cf ${USER_NAME}".tar" "/home/${USER_NAME}" &> /dev/null
            mv ${USER_NAME}".tar" /${DIR}
            #echo "Creating /archive directory."
            echo "Archiving /home/${USER_NAME} to /archive/${USER_NAME}".tar" "
        else 
            sudo mkdir ${DIR}
            sudo tar -cf ${USER_NAME}".tar" "/home/${USER_NAME}" &> /dev/null
            mv ${USER_NAME}".tar" /${DIR}
            echo "Creating /archive directory."
            echo "Archiving /home/${USER_NAME} to /archive/${USER_NAME}".tar" "    
        fi
    fi

    # Deletes the User if the option is slected
    if [[ "${DELETE}" = "true" ]] 
    then
        userdel ${REMOVE_HOME} ${USER_NAME} &> /dev/null
        
        # Check to see if the account was deleted
        if [[ "${?}" -eq 0 ]]
        then
            echo "The account ${USER_NAME} was deleted."
        else
            echo "The account ${USER_NAME} was not deleted." >&2
            exit 1            
        fi
    else
        chage -E 0 ${USER_NAME}
        if [[ "${?}" -eq 0 ]]
        then
            echo "The account ${USER_NAME} was disabled."
        else
            echo "The account ${USER_NAME} was not disabled." >&2
            exit 1            
        fi       
    fi

done

exit 0
