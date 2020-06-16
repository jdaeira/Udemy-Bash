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
while getopts :dra OPTION
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


# Checks to see if a username was entered
if [[ "${#}" -eq 0 ]]
then
    echo "You must enter at least a username"
    usage
    exit 1
fi


for USER_NAME in ${@}
do
    # Check to see if the UID of the user is at least 1000
    echo "Processing user: ${USER_NAME}"
    UID_NUM=$(id -u ${USER_NAME})

    if [[ "${UID_NUM}" -lt 1000 ]]
    then
        echo "That account can't be disabled"
        exit 1
    fi

    # Archives the Users home directory if the option is selected
    if [[ "${ARCHIVE}" = "true" ]]
    then 
        # Check to see if the archive directory exists
        DIR="/archive"
        if [[ -d "${DIR}" ]]
        then
            sudo tar -cf ${USER_NAME}".tar" "/home/${USER_NAME}" &> /dev/null
            mv ${USER_NAME}".tar" /${DIR}
            echo "Creating /archive directory."
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
    if [[ "${DELETE}" = "true" ]] && [[ "${REMOVE_HOME}" = "true" ]]
    then
        userdel -r ${USER_NAME} &> /dev/null
        if [[ "${?}" -eq 0 ]]
        then
            echo "The account ${USER_NAME} was deleted."            
        fi
    elif [[ "${DELETE}" = "true" ]]
    then
        userdel ${USER_NAME} &> /dev/null
        if [[ "${?}" -eq 0 ]]
        then
            echo "The account ${USER_NAME} was deleted."            
        fi
    else
        chage -E 0 ${USER_NAME}
        if [[ "${?}" -eq 0 ]]
        then
            echo "The account ${USER_NAME} was disabled."            
        fi        
    fi

done





