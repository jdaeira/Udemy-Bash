#!/bin/bash


# Make sure the script is being executed with superuser privileges.
USER_ID=${UID}

if [[ ${USER_ID} -ne 0 ]]
then 
  echo "You must be ROOT to create a new user" >&2 
  exit 1
fi

# If the user doesn't supply at least one argument, then give them help.
NUMBER_OF_PARAMETERS="${#}"
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then
  echo "You must enter a username and the users real name!" >&2
  exit 1  
fi

# The first parameter is the user name.
USER_NAME="${1}"

# The rest of the parameters are for the account comments.
COMMENT="${2}"

# Generate a password.
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c10)

# Create the user with the password.
sudo useradd -c "${COMMENT}" -m ${USER_NAME} 
echo ${USER_NAME}:${PASSWORD} | chpasswd

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo 'There was an error creating the account!' >&2
  exit 1
fi

# Set the password.
echo ${USER_NAME}:${PASSWORD} | chpasswd

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo 'There was an error setting the password!' >&2
  exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo
echo "Username created is: ${USER_NAME}"

# Displat the Password
echo
echo "Initial password is: ${PASSWORD}"

# Display the hostname
echo
echo "Created on ${HOSTNAME}"

exit 0